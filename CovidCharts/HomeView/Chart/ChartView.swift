//
//  ChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    
    @ObservedObject var vm: ChartViewModel

//    init(data: [DayData], chart: ChartType) {
//        self.chart = chart
//        self.data = data
//        setCustomData()
//    }
//
//    mutating func setCustomData() {
//        switch chart {
//        case .deaths: data = data.filter { $0.deaths > 0 }
//        case .confirmed: data = data.filter { $0.confirmed > 0 }
//        case .recovered: data = data.filter { $0.recovered > 0 }
//        }
//    }

    var body: some View {
        VStack (alignment: .center, spacing: 8) {
            ChartTopView(vm: vm)
            ChartContentView(vm: vm)
            ChartBottomView(vm: vm)
        }
        .frame(width: UIScreen.screenWidth-16, height: UIScreen.screenHeight/1.75)
    }
    
}
