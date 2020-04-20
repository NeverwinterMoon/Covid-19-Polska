//
//  ChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    
    var chartData: [Double] = []
    var title: String = ""
    var todayValue: Int = 0
    var maxY: Double = 0
    var midY: Double = 0
    var minX: String = ""
    var maxX: String = ""
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
                .background(Color.clear)
            ChartTopView(title: title, latestValue: todayValue)
            Spacer()
                 .frame(width: UIScreen.width, height: 8, alignment: .center)
            ChartContentView(chartData: chartData, maxY: maxY, midY: midY)
                .padding(.leading, 2)
            ChartXLine(minX: minX, maxX: maxX)
                .padding(.horizontal)
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
                .background(Color.clear)
        }
        .frame(width: UIScreen.width+32, height: UIScreen.height/1.75)
        .background(Colors.customViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chartData: [20, 40, 60, 40, 20], title: "Title", todayValue: 20, maxY: 60, midY: 40, minX: "10 March 2019", maxX: "12 March 2020")
    }
}
