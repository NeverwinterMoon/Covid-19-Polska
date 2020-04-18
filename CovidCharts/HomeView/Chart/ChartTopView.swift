//
//  ChartTopView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartTopView: View {
    
    @EnvironmentObject var vm: HomeChartViewModel
    @Binding var showLineChart: Bool
    
    var body: some View {
        VStack (spacing: 4) {
            Text(vm.getTitle(isLineChart: showLineChart))
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Color(UIColor.label))
                .frame(width: 250)
            VStack (alignment: .center, spacing: 0) {
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: UIScreen.screenWidth - 32, height: 1)
            .background(Color(UIColor.label))
            Text(String(vm.getAllCases()))
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Color(UIColor.label))
        }
    }
    
}

struct ChartTopView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopView(showLineChart: .constant(true)).environmentObject(HomeChartViewModel())
    }
}
