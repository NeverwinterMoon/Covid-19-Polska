//
//  ChartViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI
import Combine

enum ParameterType {
    case deaths, confirmed, recovered
}

enum HTTPError: LocalizedError {
    case statusCode
}

struct HomeViewPopup {
    var title: String
    var text: String
}

class ChartViewModel: ObservableObject {
    
    private var data = [Day]()
    private var dataOnIncrese = [Day]()
    @Published var regionData = [BarHorizontalDataEntity]()
    @Published var customData = [Day]()
    @Published var customIncreaseData = [Day]()
    @Published var parameter: ParameterType = .confirmed
    @Published var popup = HomeViewPopup(title: "", text: "")
    @Published var showPopup: Bool = false
    private var cancellable: AnyCancellable?
    private var cancellable2: AnyCancellable?
    
    init() {
        loadData()
    }
    
    func loadData() {
        clearData()
        fetchCovidHitoryData()
        fetchLatestData { (fetchedData) in
            self.showPopup.toggle()
            self.setPopup(title: fetchedData ? "Aktualizacja" : "Wystąpił błąd", text: fetchedData ? "Ostatnia aktualizacja:\n\(self.customData.last?.date.formattedDate(.superlong) ?? "")" : "Sprawdź połączenie z internetem")
        }
    }
    
    // MARK: - BarChart
    func fetchCovidHitoryData() {
        let urlString = "https://api.covid19api.com/country/Poland"
        guard let url = URL(string: urlString) else {
            return
        }
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
        }
        .receive(on: RunLoop.main)
        .decode(type: Days.self, decoder: JSONDecoder())
        .replaceError(with: [])
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }, receiveValue: { days in
                self.data = days
        })
    }
    
    func fetchLatestData(completion: @escaping (Bool) -> ()) {
        let urlString = "https://api.apify.com/v2/key-value-stores/3Po6TV7wTht4vIEid/records/LATEST?disableRedirect=true"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        self.cancellable2 = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(false)
                    throw HTTPError.statusCode
                }
                return output.data
        }
        .receive(on: RunLoop.main)
        .decode(type: PolandLatest.self, decoder: JSONDecoder())
        .replaceError(with: PolandLatest(infected: 0, deceased: 0, infectedByRegion: [], sourceURL: "", lastUpdatedAtApify: "", readMe: ""))
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error): fatalError(error.localizedDescription)
            }
        }, receiveValue: { latest in
                self.data.append(Day(confirmed: latest.infected, deaths: latest.deceased, recovered: self.data.last?.recovered ?? 0, date: latest.lastUpdatedAtApify))
                self.setDataFromLast(30, chart: self.parameter)
                self.setIncreaseDataFromLaset(30)
                latest.infectedByRegion.forEach { (region) in
                    self.regionData.append(BarHorizontalDataEntity(title: region.region, value1: Double(region.infectedCount), value2: Double(region.deceasedCount)))
                }
            print(latest.lastUpdatedAtApify)
            self.data.count > 1 ? completion(true) : completion(false)
        })
    }
    
    // MARK: - Charts
    func clearData() {
        data.removeAll()
        customData.removeAll()
        regionData.removeAll()
    }
    
    func setChartTitle() -> String {
        switch parameter {
        case .confirmed: return "Zakażenia"
        case .deaths: return "Zgony"
        case .recovered: return "Wyleczeni"
        }
    }
    
    func setDataFromLast(_ daysNumber: Int, chart: ParameterType) {
        self.parameter = chart
        customData = data.suffix(daysNumber)
    }
    
    func setIncreaseDataFromLaset(_ daysNumber: Int) {
        for num in 1..<data.count {
            let confirmed = data[num].confirmed - data[num-1].confirmed
            let deaths = data[num].deaths - data[num-1].deaths
            let recovered = data[num].recovered - data[num-1].recovered
            let day = Day(confirmed: confirmed, deaths: deaths, recovered: recovered, date: data[num].date)
            dataOnIncrese.append(day)
        }
        customIncreaseData = dataOnIncrese.suffix(daysNumber)
    }
    
    func getDailyChangeData(_ parameter: ParameterType) -> [Double] {
        var values = [Double]()
        guard !customData.isEmpty else {
            return []
        }
        for num in 1..<customData.count {
            var change: Double = 0
            switch parameter {
            case .confirmed: change = Double(customData[num].confirmed - customData[num-1].confirmed)
            case .deaths: change = Double(customData[num].deaths - customData[num-1].deaths)
            case .recovered: change = (Double(customData[num].recovered - customData[num-1].recovered))
            }
            values.append(change)
        }
        return values
    }
    
    func getDailyIncreaseData(_ parameter: ParameterType) -> [Double] {
        var values = [Double]()
        customData.forEach { day in
            switch parameter {
            case .confirmed: values.append(Double(day.confirmed))
            case .deaths: values.append(Double(day.deaths))
            case .recovered: values.append(Double(day.recovered))
            }
        }
        return values
    }
    
    func getDailyIncrease(on: Int, of: ParameterType) -> Int {
        let today = customData[on]
        var yesterday: Day = Day(confirmed: 0, deaths: 0, recovered: 0, date: "")
        if on - 1 >= 0 {
            yesterday = customData[on-1]
        } else {
            var additionalDates = data
            additionalDates = additionalDates.difference(from: customData)
            yesterday = additionalDates.last ?? Day(confirmed: 0, deaths: 0, recovered: 0, date: "")
        }
        switch of {
        case .confirmed: return today.confirmed - yesterday.confirmed
        case .deaths: return today.deaths - yesterday.deaths
        case .recovered: return today.recovered - yesterday.recovered
        }
    }
    
    func getCases(_ day: Day) -> CGFloat {
        switch parameter {
        case .deaths: return CGFloat(day.deaths)
        case .confirmed: return CGFloat(day.confirmed)
        case .recovered: return CGFloat(day.recovered)
        }
    }
    
    func getLatestDate(_ dateStyle: DateStyle) -> String {
        return customData.last?.date.formattedDate(dateStyle) ?? "Loading..."
    }
    
    // MARK: - TitleView
    func getLastUpdateDate() -> String {
        customData.last?.date.formattedDate(.superlong) ?? "Loading..."
    }
    
    func getConfirmedCases() -> String {
        if let last = customData.last?.confirmed {
            return String(last)
        } else {
            return "Loading..."
        }
    }
    
    func getLatestIncrease() -> String {
        guard customData.count > 0 else {
            return "Loading..."
        }
        return String(getDailyIncrease(on: customData.count-1, of: .confirmed))
    }
    
    func getMinDate() -> String {
        return customData.first?.date.formattedDate(.long) ?? "Error loading date"
    }
    
    func getMaxDate() -> String {
        return customData.last?.date.formattedDate(.long) ?? "Error loading date"
    }
    
    func setPopup(title: String, text: String) {
        popup.title = title
        popup.text = text
    }
    
}
