//
//  ChartsViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

// MARK: - Day
struct Day: Decodable, Hashable {
    let country: Country
    let countryCode: CountryCode
    let confirmed, deaths, recovered, active: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}

enum Country: String, Decodable {
    case poland = "Poland"
}

enum CountryCode: String, Decodable {
    case pl = "PL"
}

typealias Days = [Day]

struct TimeSeries: Decodable {
    let Poland: [Day]
}

struct DayData: Decodable, Hashable {
    let date: String
    let confirmed, deaths, recovered: Int
}

class ChartViewModel: ObservableObject {
    
    @Published var data = [Day]()
    @Published var chart: ChartType = .confirmed
    @Published var customData = [Day]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let urlString = "https://api.covid19api.com/country/Poland"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let timeSeries = try JSONDecoder().decode(Days.self, from: data)
                DispatchQueue.main.async {
                    self.data = timeSeries
                    self.setCustomData(.confirmed)
                }
            } catch {
                print("JSON Decode failed:", error)
            }
        }
        .resume()
    }
    
    func setCustomData(_ chart: ChartType) {
        self.chart = chart
        switch chart {
        case .deaths: customData = data.filter { $0.deaths > 0 }
        case .confirmed: customData = data.filter { $0.confirmed > 0 }
        case .recovered: customData = data.filter { $0.recovered > 0 }
        }
    }
    
    func getTitle() -> String {
        switch chart {
        case .deaths: return "Liczba zgonów"
        case .confirmed: return "Potwierdzone przypadki"
        case .recovered: return "Wyleczone przypadki"
        }
    }
    
    func getAllCases() -> Int {
        switch chart {
        case .deaths:
            return self.customData.max(by: { (day1, day2) -> Bool in
                return day2.deaths > day1.deaths
            })?.deaths ?? 0
        case .confirmed:
            return self.customData.max(by: { (day1, day2) -> Bool in
                return day2.confirmed > day1.confirmed
            })?.confirmed ?? 0
        case .recovered:
            return self.customData.max(by: { (day1, day2) -> Bool in
                return day2.recovered > day1.recovered
            })?.recovered ?? 0
        }
    }
    
    func getCases(_ day: Day) -> CGFloat {
        switch chart {
        case .deaths: return CGFloat(day.deaths)
        case .confirmed: return CGFloat(day.confirmed)
        case .recovered: return CGFloat(day.recovered)
        }
    }
    
    func getBarWidth() -> CGFloat {
        return (UIScreen.screenWidth - CGFloat(self.customData.count * 2) - 32) / CGFloat(self.customData.count)
    }
    
    func getDataFromLast(_ daysNumber: Int) {
        customData = customData.suffix(daysNumber)
    }
    
}
