//
//  ChartSideView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartSideView: View {
    
    @EnvironmentObject var vm: HomeChartViewModel
    @Binding var showLineChart: Bool
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                ChartSmallText(text: "\(vm.getChartMaxValue(isLineChart: showLineChart))")
                Spacer()
                ChartSmallText(text: "\(vm.getChartMidValue(isLineChart: showLineChart))")
                Spacer()
                ChartSmallText(text: "\(vm.getChartLowValue(isLineChart: showLineChart))")
            }
            Spacer()
        }
        .offset(x: 8, y: -8)
    }
    
}

struct ChartSideView_Previews: PreviewProvider {
    static var previews: some View {
        ChartSideView(showLineChart: .constant(true)).environmentObject(HomeChartViewModel())
    }
}
