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
    case deaths, confirmed, recovered, confirmedInc, deathsInc, recoveredInc, date
}

enum HTTPError: LocalizedError {
    case statusCode
}

struct HomeViewPopup {
    var title: String
    var text: String
}

struct DailyData: Hashable {
    var confirmed: Int
    var deaths: Int
    var recovered: Int
    var confirmedInc: Int
    var deathsInc: Int
    var recoveredInc: Int
    var date: String
}

class ChartViewModel: ObservableObject {
    
    private var fetchedData = [Day]()
    @Published var dailyData = [DailyData]()
    @Published var regionData = [BarHorizontalDataEntity]()
    @Published var parameter: ParameterType = .confirmedInc
    @Published var popup = HomeViewPopup(title: "", text: "")
    @Published var showPopup: Bool = false
    
    @Published var showHighlightedData: Bool = false
    @Published var highlightedData = DailyData(confirmed: 0, deaths: 0, recovered: 0, confirmedInc: 0, deathsInc: 0, recoveredInc: 0, date: "")
    
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
            self.setPopup(title: fetchedData ? "Aktualizacja" : "Wystąpił błąd", text: fetchedData ? "Ostatnia aktualizacja:\n\(self.dailyData.last?.date.formattedDate(.superlong) ?? "")" : "Sprawdź połączenie z internetem")
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
                self.fetchedData = days
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
                self.fetchedData.append(Day(confirmed: latest.infected, deaths: latest.deceased, recovered: self.fetchedData.last?.recovered ?? 0, date: latest.lastUpdatedAtApify))
                latest.infectedByRegion.forEach { (region) in
                    self.regionData.append(BarHorizontalDataEntity(title: region.region, value1: Double(region.infectedCount), value2: Double(region.deceasedCount)))
                }
            self.fetchedData.forEach { (day) in
                self.dailyData.append(DailyData(confirmed: day.confirmed, deaths: day.deaths, recovered: day.recovered, confirmedInc: 0, deathsInc: 0, recoveredInc: 0, date: day.date))
            }
            self.setDataOnDailyChange()
            self.setDataFromLast(30, chart: self.parameter)
            
            self.fetchedData.count > 1 ? completion(true) : completion(false)
        })
    }
    
    // MARK: - Charts
    func clearData() {
        fetchedData.removeAll()
        dailyData.removeAll()
        regionData.removeAll()
    }
    
    var chartTitle: String {
        switch parameter {
        case .confirmed: return "Zakażenia"
        case .deaths: return "Zgony"
        case .recovered: return "Wyleczeni"
        case .confirmedInc: return "Przyrost zakażeń"
        case .deathsInc: return "Przyrost zgonów"
        case .recoveredInc: return "Przyrost wyzdrowień"
        case .date: return "Data"
        }
    }
    
    var minDate: String {
        return dailyData.first?.date.formattedDate(.long) ?? "Error loading date"
    }
    
    var maxDate: String {
        return dailyData.last?.date.formattedDate(.long) ?? "Error loading date"
    }
    
    #warning("Change it causes errors")
    func setDataFromLast(_ daysNumber: Int, chart: ParameterType) {
        self.parameter = chart
        dailyData = dailyData.suffix(daysNumber)
    }
    
    func setDataOnDailyChange() {
        guard !fetchedData.isEmpty else {
            return
        }
        for num in 1..<fetchedData.count {
            dailyData[num].confirmedInc = fetchedData[num].confirmed - fetchedData[num-1].confirmed
            dailyData[num].deathsInc = fetchedData[num].deaths - fetchedData[num-1].deaths
            dailyData[num].recoveredInc = fetchedData[num].recovered - fetchedData[num-1].recovered
        }
    }
    
    func getData(_ parameter: ParameterType) -> [Double] {
        var values = [Double]()
        guard !dailyData.isEmpty else {
            return []
        }
        dailyData.forEach { (day) in
            switch self.parameter {
            case .confirmed: values.append(Double(day.confirmed))
                case .deaths: values.append(Double(day.deaths))
            case .recovered: values.append(Double(day.recovered))
            case .confirmedInc: values.append(Double(day.confirmedInc))
            case .deathsInc: values.append(Double(day.deathsInc))
            case .recoveredInc: values.append(Double(day.recoveredInc))
            default: break
            }
        }
        return values
    }
    
    func getDailyData(on: Int, of: ParameterType) -> Int {
        switch of {
        case .confirmed: return dailyData[on].confirmed
        case .deaths: return dailyData[on].deaths
        case .recovered: return dailyData[on].recovered
        case .confirmedInc: return dailyData[on].confirmedInc
        case .deathsInc: return dailyData[on].deathsInc
        case .recoveredInc: return dailyData[on].recoveredInc
        default: return 0
        }
    }
    
    func getCases(_ day: DailyData) -> CGFloat {
        switch parameter {
        case .deaths: return CGFloat(day.deaths)
        case .confirmed: return CGFloat(day.confirmed)
        case .recovered: return CGFloat(day.recovered)
        case .deathsInc: return CGFloat(day.deathsInc)
        case .confirmedInc: return CGFloat(day.confirmedInc)
        case .recoveredInc: return CGFloat(day.recoveredInc)
        default: return 0
        }
    }
    
    func getLatestDate(_ dateStyle: DateStyle) -> String {
        return dailyData.last?.date.formattedDate(dateStyle) ?? "Loading..."
    }
    
    func getLatest(_ parameter: ParameterType) -> Int {
        guard dailyData.count > 0 else {
            return 0
        }
        switch parameter {
        case .deaths: return dailyData.last!.deaths
        case .confirmed: return dailyData.last!.confirmed
        case .recovered: return dailyData.last!.recovered
        case .deathsInc: return dailyData.last!.deathsInc
        case .confirmedInc: return dailyData.last!.confirmedInc
        case .recoveredInc: return dailyData.last!.recoveredInc
        default: return 0
        }
    }
    
    func setPopup(title: String, text: String) {
        popup.title = title
        popup.text = text
    }
    
}
