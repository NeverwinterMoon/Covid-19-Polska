//
//  ChartTopView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartTopView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack (spacing: 4) {
            Text(vm.getChartTitle())
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Colors.label)
                .frame(width: 250)
            VStack (alignment: .center, spacing: 0) {
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: UIScreen.width - 32, height: 1)
            .background(Colors.label)
            Text("Dzisiaj: " + "\(String(vm.getTodayValue()))")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Colors.label)
        }
    }
    
}

struct ChartTopView_Previews: PreviewProvider {
    static var previews: some View {
        ChartTopView().environmentObject(ChartViewModel())
    }
}
