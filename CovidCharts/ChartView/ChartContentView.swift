//
//  ChartContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartContentView: View {
    
    var chartData: [Double]
    var maxY: Double
    var midY: Double

    let style = ChartStyle(backgroundColor: Color.red, accentColor: Color.blue, gradientColor: GradientColors.green, textColor: Color.clear, legendTextColor: Color.clear, dropShadowColor: Color.yellow)
    
    var body: some View {
        ZStack {
            ChartYLine(max: maxY, mid: midY)
                .padding(.leading, 16)
            VStack (spacing: 8) {
                LineView(data: chartData, style: style)
            }
            .animation(.easeInOut(duration: 0.5))
        }
    }

}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView(chartData: [20, 40, 60, 40, 20], maxY: 60, midY: 40).environmentObject(ChartViewModel())
    }
}
