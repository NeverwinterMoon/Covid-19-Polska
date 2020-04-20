//
//  BarChartViewModel.swift
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

class ChartDatabase: ObservableObject {
    
    private var data = [Day]()
    @Published var regionData = [RegionData]()
    @Published var customData = [Day]()
    @Published var parameter: ParameterType = .confirmed
    @Published var showDailyChange: Bool = true
    
    init() {
        loadData()
        loadLatestData()
    }

    // MARK: - Networking
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
                    self.setDataFromLast(30, chart: self.parameter)
                    latest.infectedByRegion.forEach { (region) in
                        self.regionData.append(RegionData(region: region.region, confirmed: region.infectedCount, deaths: region.infectedCount))
                    }
                    print(self.customData)
                }
            } catch {
                print("JSON Decode failed:", error)
            }
        }
        .resume()
    }
    
    // MARK: - Charting
    func setDataFromLast(_ daysNumber: Int, chart: ParameterType) {
        self.parameter = chart
        customData = data.suffix(daysNumber)
    }
    
    func getDailyChangesData() -> [Double] {
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
    
    func getDailyIncreaseData() -> [Double] {
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
    
    func getChartTitle() -> String {
        switch parameter {
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
        switch parameter {
        case .deaths: return CGFloat(day.deaths)
        case .confirmed: return CGFloat(day.confirmed)
        case .recovered: return CGFloat(day.recovered)
        }
    }
    
    // MARK: - TitleView
    func getLastUpdateDate() -> String {
        customData.last?.date.formattedDate(.superlong) ?? "Error loading update"
    }
    
    func getData(_ parameter: ParameterType) -> [DailyData] {
        var data = [DailyData]()
        self.data.forEach { (day) in
            switch parameter {
            case .confirmed: data.append(DailyData(date: day.date, number: day.confirmed))
            case .deaths: data.append(DailyData(date: day.date, number: day.deaths))
            case .recovered: data.append(DailyData(date: day.date, number: day.recovered))
            }
        }
        return data
    }
    
    func getMinDate() -> String {
        return customData.first?.date.formattedDate(.long) ?? "Error loading date"
    }
    
    func getMaxDate() -> String {
        return customData.last?.date.formattedDate(.long) ?? "Error loading date"
    }
    
}
