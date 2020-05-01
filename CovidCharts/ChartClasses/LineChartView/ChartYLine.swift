//
//  ChartYLine.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 18/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartYLine: View {
    
    @ObservedObject var chartData: ChartData
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                HStack {
                    Text(maxY)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(Colors.label)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text(midY)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(Colors.label)
                    .multilineTextAlignment(.leading)
                    .offset(x: 0, y: 11)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(Colors.label)
                    .multilineTextAlignment(.leading)
                    .offset(x: 0, y: 11)
                    Spacer()
                }
            }
            Spacer()
        }
        .offset(x: 12, y: -8)
    }
    
    var maxY: String {
        return String(chartData.onlyPoints().max() ?? 0)
    }
    
    var midY: String {
        return String((chartData.onlyPoints().max() ?? 0)/2)
        
    }
    
}

struct ChartSideView_Previews: PreviewProvider {
    static var previews: some View {
        ChartYLine(chartData: ChartData(points: [234, 45, 66]))
    }
}
