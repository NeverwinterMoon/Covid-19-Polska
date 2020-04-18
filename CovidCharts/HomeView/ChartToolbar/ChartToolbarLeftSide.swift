//
//  ChartToolbarLeftSide.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartToolbarLeftSide: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center, spacing: 2) {
            
            Button(action: {
                print("Calendar tapped")
            }) {
                IconView(name: Images.calendar, size: .medium, weight: .regular, color: Color(UIColor.systemPink))

                .frame(width: 30, height: 40, alignment: .center)
            }
            Button(action: {
                self.vm.showDailyChange.toggle()
            }) {
                IconView(name: vm.showDailyChange ? Images.bars : Images.percent, size: .medium, weight: .regular, color: Color(UIColor.systemPink))
                .frame(width: 30, height: 40, alignment: .center)
            }
            
        }
        .frame(width: 80, height: 40, alignment: .leading)
        .padding(.leading, 24)
        .background(Colors.customViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

struct ChartToolbarLeftSide_Previews: PreviewProvider {
    static var previews: some View {
        ChartToolbarLeftSide().environmentObject(ChartViewModel())
    }
}


