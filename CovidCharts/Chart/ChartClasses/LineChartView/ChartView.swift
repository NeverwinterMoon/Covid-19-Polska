//
//  ChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

public class ChartCustomData: ObservableObject, Identifiable {
    @Published var data: [Double]
    var valuesGiven: Bool = false
    var ID = UUID()
    
    init(data: [Double]) {
        self.data = data
    }

}

struct ChartView: View {
    
    static let height = UIScreen.height / 2.2
    static let width = UIScreen.width + 2
    
    @ObservedObject var chartData: ChartData
    
    var title: String = ""
    var minX: String = ""
    var maxX: String = ""
    
    init(data: [Double], title: String, minX: String, maxX: String) {
        self.chartData = ChartData(points: data)
        self.title = title
        self.minX = minX
        self.maxX = maxX
    }
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            ChartContentView(chartData: chartData)
        }
        .frame(width: ChartView.width + 2, height: ChartView.height)

    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(data: [23, 43, 53], title: "Title", minX: "10 March 2019", maxX: "12 March 2020")
    }
}
