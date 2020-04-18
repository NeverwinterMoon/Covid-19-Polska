//
//  ChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(showLineChart: .constant(true)).environmentObject(HomeChartViewModel())
    }
}

struct ChartView: View {
    
    @EnvironmentObject var vm: HomeChartViewModel
    @Binding var showLineChart: Bool
    
    var body: some View {
        VStack (alignment: .center, spacing: 8) {
            ChartTopView(showLineChart: $showLineChart)
                .padding(.top, 16)
            ChartContentView(showLineChart: $showLineChart)
                .padding(.leading, 2)
            ChartBottomView()
                .padding(.bottom, 16)
                .padding(.horizontal)
        }
        .frame(width: UIScreen.screenWidth+32, height: UIScreen.screenHeight/1.75)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    //    .animation(.easeInOut(duration: 0.7))
    }
    
}
