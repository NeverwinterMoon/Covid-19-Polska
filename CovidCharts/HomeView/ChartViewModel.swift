//
//  BarChartViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI
import Combine

class DataFetcher: ObservableObject {
    
    @Published var data = [Day]()
    
    let shared = DataFetcher()
    
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
                }
            } catch {
                print("JSON Decode failed:", error)
            }
        }
        .resume()
    }
    
}

enum ChartType {
    case deaths, confirmed, recovered
}

class ChartViewModel: ObservableObject {
    
    private var data = [Day]()
    @Published var customData = [Day]()
    @Published var chart: ChartType = .confirmed
    @Published var showDailyChange: Bool = true
    
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
                    self.setDataFromLast(30, chart: self.chart)
                }
            } catch {
                print("JSON Decode failed:", error)
            }
        }
        .resume()
    }
    
    func setDataFromLast(_ daysNumber: Int, chart: ChartType) {
        self.chart = chart
        customData = data.suffix(daysNumber)
    }
    
    func getDailyChangesData() -> [Double] {
        var values = [Double]()
        for num in 0..<customData.count {
            let higherValue = num + 1
            guard higherValue + 2 < customData.count else {
                return values
            }
            var change: Double = 0
            switch chart {
            case .confirmed: change = Double(customData[higherValue].confirmed - customData[num].confirmed)
            case .deaths: change = Double(customData[higherValue].deaths - customData[num].deaths)
            case .recovered: change = (Double(customData[higherValue].recovered - customData[num].recovered))
            }
            #warning("Hack")
            values.append(change+1)
        }
        return values
    }
    
    func getDailyIncreaseData() -> [Double] {
        var values = [Double]()
        customData.forEach { day in
            switch chart {
            case .confirmed: values.append(Double(day.confirmed))
            case .deaths: values.append(Double(day.deaths))
            case .recovered: values.append(Double(day.recovered))
            }
        }
        return values
    }
    
    func getChartTitle() -> String {
        switch chart {
        case .deaths: return showDailyChange ? "Dzienna liczba zgonów" : "Liczba zgonów"
        case .confirmed: return showDailyChange ? "Dzienne potwierdzone przypadki" : "Potwierdzone przypadki"
        case .recovered: return showDailyChange ? "Dzienne wyleczone przypadki" : "Wyleczone przypadki"
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
    
    func getChartMaxValue() -> Double {
        return showDailyChange ? (getDailyChangesData().max() ?? 0) - 1 : (getDailyIncreaseData().max() ?? 0) - 1
    }
    
    func getChartMidValue() -> Double {
         let last = showDailyChange ? (getDailyChangesData().max() ?? 0) - 1 : (getDailyIncreaseData().max() ?? 0) - 1
         return last / 2
    }
    
    func getCases(_ day: Day) -> CGFloat {
        switch chart {
        case .deaths: return CGFloat(day.deaths)
        case .confirmed: return CGFloat(day.confirmed)
        case .recovered: return CGFloat(day.recovered)
        }
    }
    
}
