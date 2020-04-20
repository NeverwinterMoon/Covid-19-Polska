//
//  BarChartViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI
import Combine

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
        loadLatestData()
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
    
    func loadLatestData() {
        let urlString = "https://api.apify.com/v2/key-value-stores/3Po6TV7wTht4vIEid/records/LATEST?disableRedirect=true"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let latest = try JSONDecoder().decode(PolandLatest.self, from: data)
                DispatchQueue.main.async {
                    self.data.append(Day(confirmed: latest.infected, deaths: latest.deceased, recovered: self.data.last?.recovered ?? 0, date: latest.lastUpdatedAtApify))
                    self.setDataFromLast(30, chart: self.chart)
                    self.customData.forEach { (day) in
                        print(day)
                    }
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
        guard !customData.isEmpty else {
            return []
        }
        for num in 1..<customData.count {
            var change: Double = 0
            switch chart {
            case .confirmed: change = Double(customData[num].confirmed - customData[num-1].confirmed)
            case .deaths: change = Double(customData[num].deaths - customData[num-1].deaths)
            case .recovered: change = (Double(customData[num].recovered - customData[num-1].recovered))
            }
            values.append(change)
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
    
    func getDailyIncrease(on: Int, of: ChartType) -> Int {
        let today = customData[on]
        print(today)
        let yesterday = customData[on-1]
        print(yesterday)
        switch of {
        case .confirmed: return today.confirmed - yesterday.confirmed
        case .deaths: return today.deaths - yesterday.deaths
        case .recovered: return today.recovered - yesterday.recovered
        }
    }
    
    func getChartTitle() -> String {
        switch chart {
        case .deaths: return showDailyChange ? "Liczba zgonów" : "Liczba zgonów"
        case .confirmed: return showDailyChange ? "Potwierdzone przypadki" : "Potwierdzone przypadki"
        case .recovered: return showDailyChange ? "Wyleczone przypadki" : "Wyleczone przypadki"
        }
    }
    
    func getTodayValue() -> Int {
        return showDailyChange ? Int((getDailyChangesData().last ?? 0)) : Int((getDailyIncreaseData().last ?? 0))
    }
    
    func getChartMaxValue() -> Double {
        return showDailyChange ? (getDailyChangesData().max() ?? 0) : (getDailyIncreaseData().max() ?? 0)
    }
    
    func getChartMidValue() -> Double {
         let last = showDailyChange ? (getDailyChangesData().max() ?? 0) : (getDailyIncreaseData().max() ?? 0)
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
