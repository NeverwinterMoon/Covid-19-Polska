//
//  HomeCalendarView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 01/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeCalendarView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showCalendar: Bool
    
    var body: some View {

            VStack (spacing: 16) {
                
                MenuSelectionView(title: "Ostatnie 7 dni") {
                    self.vm.daysNumber = 7
                    self.vm.setVisibleData()
                    self.showCalendar.toggle()
                }
                MenuSelectionView(title: "Ostatnie 30 dni") {
                    self.vm.daysNumber = 30
                    self.vm.setVisibleData()
                    self.showCalendar.toggle()
                }
                MenuSelectionView(title: "Cała historia") {
                    self.vm.daysNumber = self.vm.loadedDailyData.count
                    self.vm.setVisibleData()
                    self.showCalendar.toggle()
                }
                Button(action: {
                    self.showCalendar.toggle()
                }) {
                    Text("Zamknij")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Colors.background)
                    .frame(width: 200, height: 44, alignment: .center)
                }
                .background(RoundedCorners(color: Colors.chartBot, tl: 16, tr: 16, bl: 16, br: 16))
                .shadow(color: Colors.chartBot.opacity(0.6), radius: 8, x: 2, y: 5)
                
            }
    }
}

struct HomeCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCalendarView(showCalendar: .constant(true))
    }
}
