//
//  ChartContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartContentView: View {
    
    @EnvironmentObject var vm: ChartViewModel

    let chartStyle = ChartStyle(backgroundColor: Color(UIColor.systemBackground), accentColor: Color.black, gradientColor: GradientColors.orngPink, textColor: Color.yellow, legendTextColor: Color.blue, dropShadowColor: Color.orange)
    
    var body: some View {
        ZStack {
            ChartGrid()
                .padding(.leading, 16)
            VStack (spacing: 8) {
                LineView(data: vm.showDailyChange ? self.vm.getDailyChangesData() : self.vm.getDailyIncreaseData(), style: chartStyle)
            }
            .animation(.easeInOut(duration: 0.5))
        }
    }

}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView().environmentObject(ChartViewModel())
    }
}

//struct BarChartView: View {
//
//    @EnvironmentObject var vm: ChartViewModel
//
//    var body: some View {
//        VStack (spacing: 8) {
//            HStack (alignment: .bottom, spacing: 2) {
//                ForEach(vm.customData, id: \.self) { day in
//                    VStack (spacing: 5) {
//                        VStack {
//                            Spacer()
//                        }
//                        .frame(width: self.vm.getBarWidth(), height: (self.vm.getCases(day) / CGFloat(self.vm.getAllCases())) * (UIScreen.screenHeight/1.75 - 100))
//                        .background(Color(UIColor.systemPink))
//                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
//                    }
//                }
//            }
//        }
//        .padding(.horizontal)
//        .animation(Animation.easeInOut(duration: 0.75))
//
//    }
//}
