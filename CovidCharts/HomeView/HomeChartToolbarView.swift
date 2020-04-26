//
//  HomeChartToolbarView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeChartToolbarView: View {
    
    @Binding var showDetailsView: Bool
    @Binding var showPopup: Bool
    
    var body: some View {
        VStack {
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
            HStack {
                ToolbarLeft(showDetailsView: $showDetailsView)
                .frame(width: 140, height: 50, alignment: .leading)
                .background(RoundedCorners(color: Colors.appBackground, tl: 0, tr: 16, bl: 0, br: 16))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                Spacer()
                ToolbarRight()
                .frame(width: 100, height: 50, alignment: .leading)
                .background(RoundedCorners(color: Colors.appBackground, tl: 16, tr: 0, bl: 16, br: 0))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            }
            .frame(width: UIScreen.width, height: 40, alignment: .center)
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
        }

    }
    
}

struct ChartToolbar_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartToolbarView(showDetailsView: .constant(false), showPopup: .constant(false))
    }
}

struct ToolbarLeft: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showDetailsView: Bool
    
    var body: some View {
        HStack (alignment: .center, spacing: 2) {
            
            Button(action: {
                self.vm.showPopup.toggle()
                self.vm.setPopup(title: "Źródło danych", text: "Wykresy tworzone na podstawie danych publikowanych przez Ministerstwo Zdrowia/WHO")
            }) {
                IconView(name: Icons.info, size: .large, weight: .semibold, color: Colors.main)
                .frame(width: 40, height: 50, alignment: .center)
            }
            .padding(.leading, 6)
            
            Button(action: {
                self.vm.showPopup.toggle()
                self.vm.setPopup(title: "Kalendarz", text: "Funkcja dostępna wkrótce")
            }) {
                IconView(name: Icons.calendar, size: .large, weight: .semibold, color: Colors.main)
                    
                .frame(width: 40, height: 50, alignment: .center)
            }
            
            Button(action: {
                self.showDetailsView.toggle()
            }) {
                IconView(name: Icons.more, size: .large, weight: .semibold, color: Colors.main)
                .frame(width: 40, height: 50, alignment: .center)
            }
            
        }
    }
}

struct ToolbarRight: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center, spacing: 2) {
            
            Button(action: {
                self.vm.setDataFromLast(30, chart: .deathsInc)
            }) {
                IconView(name: Icons.table, size: .large, weight: .semibold, color: Colors.main)
                    
                .frame(width: 40, height: 50, alignment: .center)
            }.padding(.leading, 8)
            
            Button(action: {
                self.vm.setDataFromLast(30, chart: .recoveredInc)
            }) {
                IconView(name: Icons.bars, size: .large, weight: .semibold, color: Colors.main)
                .frame(width: 40, height: 50, alignment: .center)
            }
            
        }
    }
}
