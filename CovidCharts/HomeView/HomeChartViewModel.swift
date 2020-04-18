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

class HomeChartViewModel: ObservableObject {
    
    private var data = [Day]()
    @Published var customData = [Day]()
    @Published var chart: ChartType = .confirmed
    
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
    
    func getCustomLineData() -> [Double] {
        var changes = [Double]()
        for num in 0..<customData.count {
            let higherValue = num + 1
            guard higherValue + 2 < customData.count else {
                 print(changes)
                return changes
            }
            var change: Double = 0
            switch chart {
            case .confirmed: change = Double(customData[higherValue].confirmed - customData[num].confirmed)
            case .deaths: change = Double(customData[higherValue].deaths - customData[num].deaths)
            case .recovered: change = (Double(customData[higherValue].recovered - customData[num].recovered))
            }
            print(change)
            #warning("Hack")
            changes.append(change+1)
        }
        return changes
    }
    
    private func getCustomBarData() -> [Double] {
        var separatedData = [Double]()
        customData.forEach { day in
            switch chart {
            case .confirmed: separatedData.append(Double(day.confirmed))
            case .deaths: separatedData.append(Double(day.deaths))
            case .recovered: separatedData.append(Double(day.recovered))
            }
        }
        return separatedData
    }
    
    func getTitle(isLineChart: Bool) -> String {
        switch chart {
        case .deaths: return isLineChart ? "Dzienna liczba zgonów" : "Liczba zgonów"
        case .confirmed: return isLineChart ? "Dzienne potwierdzone przypadki" : "Potwierdzone przypadki"
        case .recovered: return isLineChart ? "Dzienne wyleczone przypadki" : "Wyleczone przypadki"
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
    
    func getChartMaxValue(isLineChart: Bool) -> Double {
        return isLineChart ? (getCustomLineData().max() ?? 0) - 1 : getCustomBarData().last ?? 0
    }
    
    func getChartMidValue(isLineChart: Bool) -> Double {
        guard let last = isLineChart ? (getCustomLineData().max() ?? 0) - 1 : getCustomBarData().last else {
            return 0
        }
        guard let first = isLineChart ? ((getCustomLineData().min() ?? 0) - 1) : getCustomBarData().first else {
            return 0
        }
        
        return ((last-first)/2) + first
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
    
    func setDataFromLast(_ daysNumber: Int, chart: ChartType) {
        self.chart = chart
        customData = data.suffix(daysNumber)
    }
    
}
