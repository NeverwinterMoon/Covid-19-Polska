//
//  ChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    
    static let height = UIScreen.height / 1.75
    static let width = UIScreen.width - 32
    
    @State var chartData: [Double] = []
    @State var title: String = ""
    @State var minX: String = ""
    @State var maxX: String = ""
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
                .background(Color.clear)
            ChartTopView(title: title, latestValue: Int(chartData.last!))
            Spacer()
                 .frame(width: UIScreen.width, height: 8, alignment: .center)
            ChartContentView(chartData: chartData, maxY: chartData.max()!, midY: chartData.max()!/2)
                .padding(.leading, 2)
            ChartXLine(minX: minX, maxX: maxX)
                .padding(.horizontal)
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
                .background(Color.clear)
        }
        .frame(width: ChartView.width+64, height: ChartView.height)
        .background(Colors.customViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
        .listRowBackground(Colors.appBackground)
    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chartData: [20, 40, 60, 40, 20], title: "Title", minX: "10 March 2019", maxX: "12 March 2020")
    }
}
