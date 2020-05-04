//
//  HomeMenuView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 29/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeMenuView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showMenu: Bool
    @State var showPolandStats: Bool = false
    @State var showProvinceStats: Bool = false
    @State var showGlobalStats: Bool = false
    @State var showLicences: Bool = false
    
    var body: some View {

            VStack (spacing: 16) {
                Spacer()
                MenuSelectionView(title: "Świat") {
                    self.showGlobalStats.toggle()
                }.sheet(isPresented: $showGlobalStats) {
                    GlobalStatsView(vm: GlobalStatsViewModel(data: self.vm.globalData), showView: self.$showGlobalStats)
                }
                
                MenuSelectionView(title: "Polska") {
                    self.showPolandStats.toggle()
                }.sheet(isPresented: $showPolandStats) {
                    PolandStatsView(showView: self.$showPolandStats).environmentObject(self.vm)
                }
                
                MenuSelectionView(title: "Województwa") {
                    self.showProvinceStats.toggle()
                }.sheet(isPresented: $showProvinceStats) {
                    ProvinceStatsView(showView: self.$showProvinceStats).environmentObject(self.vm)
                }
                
                Button(action: {
                    self.showMenu.toggle()
                }) {
                    Text("Zamknij")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Colors.background)
                    .frame(width: 200, height: 44, alignment: .center)
                }
                .background(RoundedCorners(color: Colors.main2, tl: 16, tr: 16, bl: 16, br: 16))
                .shadow(color: Colors.main2.opacity(0.8), radius: 8, x: 0, y: 5)
                Spacer()
                Button(action: {
                    self.showLicences.toggle()
                }) {
                  Text("Licenses & Credits")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(Colors.customViewBackground)
                    .opacity(0.2)
                }.sheet(isPresented: $showLicences) {
                    LicencesView(showView: self.$showLicences)
                }
            }
    }
}

struct HomeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenuView(showMenu: .constant(true))
    }
}

struct MenuSelectionView: View {
    
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(title)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Colors.label)
                .frame(width: 200, height: 44, alignment: .center)
        }
        .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 16, bl: 16, br: 16))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}
