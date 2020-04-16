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
    
    var body: some View {
        ZStack {
            ChartSideView()
            .padding(.leading, 16)
            VStack (spacing: 8) {
                HStack (alignment: .bottom, spacing: 2) {
                    ForEach(vm.customData, id: \.self) { day in
                        VStack (spacing: 5) {
                            VStack {
                                Spacer()
                            }
                            .frame(width: self.vm.getBarWidth(), height: (self.vm.getCases(day) / CGFloat(self.vm.getAllCases())) * (UIScreen.screenHeight/1.75 - 100))
                            .background(Color(UIColor.systemPink))
                            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .animation(Animation.easeInOut(duration: 0.75))
        }
    }

}

struct ChartContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartContentView().environmentObject(ChartViewModel())
    }
}
