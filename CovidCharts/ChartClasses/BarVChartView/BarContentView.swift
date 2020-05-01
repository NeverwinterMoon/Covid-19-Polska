//
//  BarContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 21/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct BarContentView: View {
    
    @ObservedObject var chartData: ChartData
    @State var isShowing: Bool
    var animation: Animation {
        Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)
    }

    let style = ChartStyle(backgroundColor: Color.red, accentColor: Color.blue, gradientColor: GradientColors.green, textColor: Color.clear, legendTextColor: Color.clear, dropShadowColor: Color.yellow)
    
    var body: some View {
        ZStack {
                ChartYLine(chartData: chartData)
                .padding(.leading, 16)
            VStack (spacing: 8) {
                
                HStack (alignment: .bottom, spacing: 4) {
                    Spacer()
                    ForEach(chartData.onlyPoints(), id: \.self) { dailyData in
                        Spacer()
                            .frame(width: self.barWidth(), height: self.barHeight(dailyData), alignment: .center)
                            .background(LinearGradient(gradient: Gradient(colors: [Colors.graphGradient, Colors.customViewBackground]), startPoint: .top, endPoint: .bottom))
                            
                    }
                    Spacer()
                }
                
            }
            .onAppear {
                withAnimation(self.animation) {
                    self.isShowing.toggle()
                }
            }
        }
                
    }
    
    var max: Double {
        return chartData.onlyPoints().max() ?? 0
    }
    
    func barHeight(_ dailyData: Double) -> CGFloat {
        let chartHeight = ChartView.height - 100
        return CGFloat(dailyData/max) * chartHeight
    }
    
    func barWidth() -> CGFloat {
        let chartWidth = ChartView.width-54
        return chartWidth/CGFloat(chartData.onlyPoints().count) - 2
    }

}

struct BarContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarContentView(chartData: ChartData(points: [152.0, 150.0, 170.0, 168.0, 249.0, 224.0, 193.0, 256.0, 243.0, 392.0, 437.0, 244.0, 475.0, 311.0, 435.0, 357.0, 370.0, 380.0, 401.0, 318.0, 260.0, 268.0, 380.0, 336.0, 461.0, 363.0, 545.0, 306.0, 144.0]), isShowing: true)
    }
}
