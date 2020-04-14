//
//  ChartContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartContentView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        ZStack {
            ChartSideView(vm: vm)
            VStack (spacing: 8) {
                HStack (alignment: .bottom, spacing: 2) {
                    ForEach(vm.customData, id: \.self) { day in
                        VStack (spacing: 5) {
                            VStack {
                                Spacer()
                            }
                            .frame(width: self.vm.getBarWidth(), height: (self.vm.getCases(day) / CGFloat(self.vm.getAllCases())) * (UIScreen.screenHeight/1.75 - 100))
                            .background(Colors.mainColor)
                        }
                    }
                }
            }
        }
    }
    
//    func setMaximumHeight() -> Int {
//        switch chart {
//        case .deaths:
//            return self.data.max(by: { (day1, day2) -> Bool in
//                return day2.deaths > day1.deaths
//            })?.deaths ?? 0
//        case .confirmed:
//            return self.data.max(by: { (day1, day2) -> Bool in
//                return day2.confirmed > day1.confirmed
//            })?.confirmed ?? 0
//        case .recovered:
//            return self.data.max(by: { (day1, day2) -> Bool in
//                return day2.recovered > day1.recovered
//            })?.recovered ?? 0
//        }
//    }
//
//    func setHeight(_ day: DayData) -> CGFloat {
//        switch chart {
//        case .deaths: return CGFloat(day.deaths)
//        case .confirmed: return CGFloat(day.confirmed)
//        case .recovered: return CGFloat(day.recovered)
//        }
//    }
//
//    func setBarWidth() -> CGFloat {
//        return (UIScreen.screenWidth - CGFloat(self.data.count * 2) - 32) / CGFloat(self.data.count)
//    }
}

struct ChartSideView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                ChartSmallText(text: "\(vm.getAllCases()/1)")
                Spacer()
                ChartSmallText(text: "\(vm.getAllCases()/2)")
                Spacer()
                ChartSmallText(text: "0")
            }
            Spacer()
        }
        .offset(x: -2, y: -8)
    }
    
//    func setMaximumHeight() -> Int {
//        switch chart {
//        case .deaths:
//            return self.data.max(by: { (day1, day2) -> Bool in
//                return day2.deaths > day1.deaths
//            })?.deaths ?? 0
//        case .confirmed:
//            return self.data.max(by: { (day1, day2) -> Bool in
//                return day2.confirmed > day1.confirmed
//            })?.confirmed ?? 0
//        case .recovered:
//            return self.data.max(by: { (day1, day2) -> Bool in
//                return day2.recovered > day1.recovered
//            })?.recovered ?? 0
//        }
//    }
//
//    func setTitle(_ chart: ChartType) -> String {
//        switch chart {
//        case .deaths: return "Liczba zgonów"
//        case .confirmed: return "Potwierdzone przypadki"
//        case .recovered: return "Wyzdrowienia"
//        }
//    }
    
    
    
}
