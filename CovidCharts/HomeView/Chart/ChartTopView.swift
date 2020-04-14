//
//  ChartTopView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartTopView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        VStack (spacing: 4) {
            Text(vm.getTitle())
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            VStack (alignment: .center, spacing: 0) {
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: UIScreen.screenWidth - 32, height: 1)
            .background(Colors.lightBlue)
            Text(String(vm.getAllCases()))
                .font(.system(size: 16, weight: .regular, design: .default))
                .foregroundColor(Colors.white)
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
//    func setTitle(_ chart: ChartType) -> String {
//        switch chart {
//        case .deaths: return "Liczba zgonów"
//        case .confirmed: return "Potwierdzone przypadki"
//        case .recovered: return "Wyzdrowienia"
//        }
//    }
    
}
