//
//  ChartContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct ChartContentView: View {
    
    @EnvironmentObject var vm: HomeChartViewModel
    @Binding var showLineChart: Bool
    
    let chartStyle = ChartStyle(backgroundColor: Color(UIColor.systemBackground), accentColor: Color.black, gradientColor: GradientColors.orngPink, textColor: Color.yellow, legendTextColor: Color.blue, dropShadowColor: Color.orange)
    
    var body: some View {
        ZStack {
            ChartSideView(showLineChart: $showLineChart)
            .padding(.leading, 16)
            VStack (spacing: 8) {
                if self.showLineChart {
                    LineView(data: self.vm.getCustomLineData(), style: chartStyle)
                } else {
                    BarChartView()
                }
            }
        }
    }

}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView(showLineChart: .constant(true)).environmentObject(HomeChartViewModel())
    }
}

struct BarChartView: View {
    
    @EnvironmentObject var vm: HomeChartViewModel
    
    var body: some View {
        VStack (spacing: 8) {
            HStack (alignment: .bottom, spacing: 2) {
                ForEach(vm.customData, id: \.self) { day in
                    VStack (spacing: 5) {
                        VStack {
                            Spacer()
                        }
                        .frame(width: self.vm.getBarWidth(), height: (self.vm.getCases(day) / CGFloat(self.vm.getAllCases())) * (UIScreen.screenHeight/1.75 - 100))
                        .background(Color(UIColor.systemPink))
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    }
                }
            }
        }
        .padding(.horizontal)
        .animation(Animation.easeInOut(duration: 0.75))

    }
}
