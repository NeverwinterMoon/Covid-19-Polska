//
//  ChartContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartContentView: View {
    
    @ObservedObject var chartData: ChartData

    let style = ChartStyle(backgroundColor: Color.red, accentColor: Color.blue, gradientColor: GradientColors.green, textColor: Color.clear, legendTextColor: Color.clear, dropShadowColor: Color.yellow)
    
    lazy var height: CGFloat = 0
    
    var body: some View {
                ZStack {
                    VStack {
                        VStack {
                            XLine(chartData: self.chartData, multiplier: 1)
                        }
                        Spacer()
                        VStack {
                            XLine(chartData: self.chartData, multiplier: 4.5/6)
                        }
                        Spacer()
                        VStack {
                            XLine(chartData: self.chartData, multiplier: 3/6)
                        }
                        Spacer()
                        VStack {
                            XLine(chartData: self.chartData, multiplier: 1.5/6)
                        }
                        Spacer()
                    }.offset(y: -8)
                    
                    LineView(chartData: self.chartData, style: self.style)
                    
                }
                
            }
//            .background(Color.red)
//            .animation(.easeInOut(duration: 0.5))
    
}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView(chartData: ChartData(points: [2,4,5])).environmentObject(ChartViewModel())
    }
}

struct XLine: View {
    
    @ObservedObject var chartData: ChartData
    var multiplier: Double
    
    var body: some View {
        HStack {
            Text("\(Int((self.chartData.onlyPoints().max() ?? 0) * multiplier))")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(Colors.main)
                .opacity(0.3)
                .padding(.horizontal, 8)
                .animation(nil)
            Spacer()
                .frame(height: 1, alignment: .center)
                .background(Colors.main)
                .opacity(0.3)
            //    .animation(nil)
        }
    }
}
