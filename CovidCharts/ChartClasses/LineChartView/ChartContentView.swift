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
    
    var body: some View {
        ZStack {
                ChartYLine(chartData: chartData)
                .padding(.leading, 16)
            VStack (spacing: 8) {
                LineView(chartData: chartData, style: style)
            }
            .animation(.easeInOut(duration: 0.5))
        }
    }

}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView(chartData: ChartData(points: [2,4,5])).environmentObject(ChartViewModel())
    }
}
