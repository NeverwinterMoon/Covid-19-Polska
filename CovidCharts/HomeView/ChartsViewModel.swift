//
//  ChartsViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

enum ChartType {
    case deaths, confirmed, recovered
}

class ChartViewModel: ObservableObject {
    
    @Published var data = [Day]()
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
                    self.setDataFromLast(30, chart: .confirmed)
                }
            } catch {
                print("JSON Decode failed:", error)
            }
        }
        .resume()
    }
    
    func getChartLineData() -> [Double] {
        var changes = [Double]()
        switch chart {
        case .confirmed:
            for num in 0..<data.count {
                let higherValue = num+1
                guard higherValue + 2 < data.count else {
                    return changes
                }
                let change1: Double = (Double(data[higherValue].confirmed - data[num].confirmed))
//                let change2: Double = (Double(data[higherValue+1].confirmed - data[higherValue].confirmed))
//                let change: Double = Double(((change2 - change1)/change2)*100)
                changes.append(change1)
            }
        default: break
        }
        return changes
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
            return self.data.max(by: { (day1, day2) -> Bool in
                return day2.deaths > day1.deaths
            })?.deaths ?? 0
        case .confirmed:
            return self.data.max(by: { (day1, day2) -> Bool in
                return day2.confirmed > day1.confirmed
            })?.confirmed ?? 0
        case .recovered:
            return self.data.max(by: { (day1, day2) -> Bool in
                return day2.recovered > day1.recovered
            })?.recovered ?? 0
        }
    }
    
    func getMaxValue() -> Int {
        guard let last = data.last else {
            return 0
        }
        switch chart {
        case .deaths: return last.deaths
        case .confirmed: return last.confirmed
        case .recovered: return last.recovered
        }
    }
    
    func getMidValue() -> Int {
        guard let last = data.last, let first = data.first else {
            return 0
        }
        switch chart {
        case .deaths: return (last.deaths-first.deaths)/2 + first.deaths
        case .confirmed: return (last.confirmed-first.confirmed)/2 + first.confirmed
        case .recovered: return (last.recovered-first.recovered)/2 + first.recovered
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
        return (UIScreen.screenWidth - CGFloat(self.data.count * 2) - 32) / CGFloat(self.data.count)
    }
    
    func setDataFromLast(_ daysNumber: Int, chart: ChartType) {
        self.chart = chart
        data = data.suffix(daysNumber)
    }
    
}
