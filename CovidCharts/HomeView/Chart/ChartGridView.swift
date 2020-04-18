//
//  ChartGridView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 18/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartGrid: View {
    
    @EnvironmentObject var vm: HomeChartViewModel
    @Binding var showLineChart: Bool
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                HStack {
                    ChartSmallText(text: "\(vm.getChartMaxValue(isLineChart: showLineChart))")
                    Spacer()
                }
                Spacer()
                HStack {
                    ChartSmallText(text: "\(vm.getChartMidValue(isLineChart: showLineChart))")
                    Spacer()
                }
                Spacer()
                HStack {
                    ChartSmallText(text: "")
                    Spacer()
                }
            }
            Spacer()
        }
        .offset(x: 12, y: -8)
    }
    
}

struct ChartSideView_Previews: PreviewProvider {
    static var previews: some View {
        ChartGrid(showLineChart: .constant(true)).environmentObject(HomeChartViewModel())
    }
}
