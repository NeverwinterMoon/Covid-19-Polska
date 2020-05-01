//
//  ChartTopView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartTopView: View {
    
    @ObservedObject var chartData: ChartData
    var title: String
    
    var body: some View {
        VStack (spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Colors.label)
                .frame(width: 250)
            VStack (alignment: .center, spacing: 0) {
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: UIScreen.width - 32, height: 1)
            .background(Colors.label)
            Text("\(Int(chartData.onlyPoints().last ?? 0)) ")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Colors.label)
        }
    }
    
}

struct ChartTopView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopView(chartData: ChartData(points: [234, 53, 78]), title: "Chart title").environmentObject(ChartViewModel())
    }
}
