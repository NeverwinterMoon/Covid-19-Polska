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

class ChartViewModel: ObservableObject {
    
    func setRegion(_ provinceName: String) -> String {
        switch provinceName {
        case "dolnoslaskie": return "Dolnośląskie"
        case "lodzkie": return "Łódzkie"
        case "malopolskie": return "Małopolskie"
        case "slaskie": return "Śląskie"
        case "swietokrzyskie": return "Świętokrzyskie"
        case "warminsko-mazurskie": return "Warmińsko-mazurskie"
        default: return provinceName
        }
    }

    
    @Published var globalData = GlobalData(global: Global(newConfirmed: 0, totalConfirmed: 0, newDeaths: 0, totalDeaths: 0, newRecovered: 0, totalRecovered: 0), countries: [], date: "")
    
    private var fetchedData = [Day]()
    @Published var loadedDailyData = [DailyData]()
    @Published var dailyData = [DailyData]()
    @Published var regionData = [BarHorizontalDataEntity]()
    @Published var daysNumber = 30
    
    @Published var parameter: ParameterType = .confirmedInc
    @Published var popup = HomeViewPopup(title: "", text: "")
    @Published var showPopup: Bool = false
    
    @Published var showHorizontalLines: Bool = false
    @Published var showHighlightedData: Bool = false
    @Published var highlightedData = DailyData(confirmed: 0, deaths: 0, recovered: 0, confirmedInc: 0, deathsInc: 0, recoveredInc: 0, date: "")
    
    private var cancellable: AnyCancellable?
    private var cancellable2: AnyCancellable?
    private var cancellable3: AnyCancellable?
    
    init() {
    loadData()
    }
    
    func loadData() {
        clearData()
        fetchGlobalData()
        fetchPolandHistoricData()
        fetchPolandLatestData { (fetchedData) in
            self.showPopup.toggle()
            self.setPopup(title: fetchedData ? "Aktualizacja" : "Wystąpił błąd", text: fetchedData ? "Ostatnia aktualizacja bazy danych:\n\(self.dailyData.last?.date.formattedDate(.superlong) ?? "")" : "Błąd serwera lub brak połączenia z internetem. Spróbuj ponownie.")
            self.highlightedData.confirmed = self.dailyData.last?.confirmed ?? 0
            self.highlightedData.confirmedInc = self.dailyData.last?.confirmedInc ?? 0
            self.highlightedData.deaths = self.dailyData.last?.deaths ?? 0
            self.highlightedData.deathsInc = self.dailyData.last?.deathsInc ?? 0
            self.highlightedData.recovered = self.dailyData.last?.recovered ?? 0
            self.highlightedData.recoveredInc = self.dailyData.last?.recoveredInc ?? 0
        }
    }
    
    // MARK: - Networking
    func fetchPolandHistoricData() {
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
    
    func fetchGlobalData() {
        let urlString = "https://api.covid19api.com/summary"
        guard let url = URL(string: urlString) else {
            return
        }
        self.cancellable3 = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
        }
        .receive(on: RunLoop.main)
        .decode(type: GlobalData.self, decoder: JSONDecoder())
        .replaceError(with: GlobalData(global: Global(newConfirmed: 0, totalConfirmed: 0, newDeaths: 0, totalDeaths: 0, newRecovered: 0, totalRecovered: 0), countries: [], date: ""))
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }, receiveValue: { globalData in
            self.globalData = globalData
        })
    }
    
    func fetchPolandLatestData(completion: @escaping (Bool) -> ()) {
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
                    self.regionData.append(BarHorizontalDataEntity(title: self.setRegion(region.region).capitalized, value1: Double(region.infectedCount), value2: Double(region.deceasedCount)))
                }
            self.fetchedData.forEach { (day) in
                self.loadedDailyData.append(DailyData(confirmed: day.confirmed, deaths: day.deaths, recovered: day.recovered, confirmedInc: 0, deathsInc: 0, recoveredInc: 0, date: day.date))
            }
            
            // This removes positions with the same date
            if self.loadedDailyData.count > 1 {
                let count = self.loadedDailyData.count
                if self.loadedDailyData.last?.date.formattedDate(.short) == self.loadedDailyData[count-2].date.formattedDate(.short) {
                    self.loadedDailyData.remove(at: count-2)
                }
            }
            
            self.loadedDailyData = self.loadedDailyData.filter { $0.confirmed > 0 }
            self.setDataOnDailyChange()
            self.setVisibleData()
            self.fetchedData.count > 1 ? completion(true) : completion(false)
        })
    }
    
    // MARK: - Charts
    func clearData() {
        loadedDailyData.removeAll()
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
    
    func setVisibleData() {
        dailyData = loadedDailyData.suffix(daysNumber)
    }
    
    private func setDataOnDailyChange() {
        guard !loadedDailyData.isEmpty else {
            return
        }
        for num in 1..<loadedDailyData.count {
            loadedDailyData[num].confirmedInc = loadedDailyData[num].confirmed - loadedDailyData[num-1].confirmed
            loadedDailyData[num].deathsInc = loadedDailyData[num].deaths - loadedDailyData[num-1].deaths
            loadedDailyData[num].recoveredInc = loadedDailyData[num].recovered - loadedDailyData[num-1].recovered
        }
    }
    
    func getData(_ parameter: ParameterType) -> [Double] {
        var values = [Double]()
        guard !dailyData.isEmpty else {
            return []
        }
        dailyData.forEach { (day) in
            switch parameter {
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
    
    func setPopup(title: String, text: String) {
        popup.title = title
        popup.text = text
    }
    
}
