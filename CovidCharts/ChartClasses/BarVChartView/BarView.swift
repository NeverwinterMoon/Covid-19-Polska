//
//  BarView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 21/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct BarView: View {
    
    static let height = UIScreen.height / 1.75
    static let width = UIScreen.width - 32
    
    @ObservedObject var chartData: ChartData
    
    var title: String
    var minX: String
    var maxX: String
    
    init(data: [Double], title: String, minX: String, maxX: String) {
        self.chartData = ChartData(points: data)
        self.minX = minX
        self.maxX = maxX
        self.title = title
    }
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
                .background(Color.clear)
            ChartTopView(chartData: chartData, title: title)
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
            BarView(data: chartData.onlyPoints(), title: title, minX: minX, maxX: maxX)
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
        .listRowBackground(Colors.background)
    }

    var max: Int {
        return Int(chartData.onlyPoints().max() ?? 0)
    }
    
    var mid: Int {
        return Int((chartData.onlyPoints().max() ?? 0) / 2)
    }
    
    
}
struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(data: [2,5,7,9,12,2,5,6], title: "Sample", minX: "2 Marca 2019", maxX: "10 Marca 2019")
    }
}


