//
//  ProvincesStatsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 26/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ProvincesStatsView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.showView.toggle()
                }) {
                    IconView(name: Icons.hide, size: .large, weight: .medium, color: Colors.label)
                }
                .padding(.leading, 12)
                .padding(.top, 16)
                Spacer()
            }
           BarHorizontalChartView(title: "Zakażenia w województwach", data: vm.regionData, legend1: "Zakażenia", color1: Colors.main, legend2: "Zgony", color2: Colors.main2)
            Spacer()
        }.background(Colors.customViewBackground)
    }
}

struct ProvincesStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProvincesStatsView(showView: .constant(true)).environmentObject(ChartViewModel())
    }
}
