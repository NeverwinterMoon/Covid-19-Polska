//
//  ChartContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartContentView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        ZStack {
            ChartSideView(vm: vm)
            VStack (spacing: 8) {
                HStack (alignment: .bottom, spacing: 2) {
                    ForEach(vm.customData, id: \.self) { day in
                        VStack (spacing: 5) {
                            VStack {
                                Spacer()
                            }
                            .frame(width: self.vm.getBarWidth(), height: (self.vm.getCases(day) / CGFloat(self.vm.getAllCases())) * (UIScreen.screenHeight/1.75 - 100))
                            .background(Colors.mainColor)
                        }
                    }
                }
            }
        }
    }

}

struct ChartSideView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                ChartSmallText(text: "\(vm.getAllCases()/1)")
                Spacer()
                ChartSmallText(text: "\(vm.getAllCases()/2)")
                Spacer()
                ChartSmallText(text: "0")
            }
            Spacer()
        }
        .offset(x: -2, y: -8)
    }
    
}
