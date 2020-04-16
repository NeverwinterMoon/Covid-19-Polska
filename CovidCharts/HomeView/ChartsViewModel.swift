//
//  ChartsViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct TimeSeries: Decodable {
    let Poland: [DayData]
}

struct DayData: Decodable, Hashable {
    let date: String
    let confirmed, deaths, recovered: Int
}

class ChartViewModel: ObservableObject {
    
    @Published var data = [DayData]()
    @Published var chart: ChartType = .confirmed
    @Published var customData = [DayData]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let urlString = "https://pomber.github.io/covid19/timeseries.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let timeSeries = try JSONDecoder().decode(TimeSeries.self, from: data)
                DispatchQueue.main.async {
                    self.data = timeSeries.Poland
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
        print(chart)
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
    
    func getCases(_ day: DayData) -> CGFloat {
        switch chart {
        case .deaths: return CGFloat(day.deaths)
        case .confirmed: return CGFloat(day.confirmed)
        case .recovered: return CGFloat(day.recovered)
        }
    }
    
    func getBarWidth() -> CGFloat {
        return (UIScreen.screenWidth - CGFloat(self.customData.count * 2) - 32) / CGFloat(self.customData.count)
    }
    
}
