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
                ChartToolbarLeftSide()
                Spacer()
                ShowDetailsButton(showDetailsView: $showDetailsView)
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

private struct ShowDetailsButton: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showDetailsView: Bool
    
    var body: some View {
        Button(action: {
            self.showDetailsView.toggle()
        }) {
            Text("Pokaż szczegóły")
                .font(.system(size: 14, weight: .semibold, design: .default))
                .multilineTextAlignment(.leading)
                .foregroundColor(Colors.label)
                .padding(.trailing, 16)
        }
        .sheet(isPresented: $showDetailsView) {
            DetailsView(showDetailsView: self.$showDetailsView).environmentObject(self.vm)
        }
        .frame(width: 170, height: 40, alignment: .center)
        .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 0, bl: 16, br: 0))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

struct ChartToolbarLeftSide: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center, spacing: 2) {
            
            Button(action: {
                self.vm.showPopup.toggle()
                self.vm.setPopup(title: "Źródło danych", text: "Dane aktualizowane z wykorzystaniem danych publikowanych przez Ministerstwo Zdrowia/WHO")
            }) {
                IconView(name: Icons.info, size: .medium, weight: .regular, color: Colors.main)
                .frame(width: 30, height: 40, alignment: .center)
            }
            .padding(.leading, 6)
            
            Button(action: {
                self.vm.showPopup.toggle()
                self.vm.setPopup(title: "Kalendarz", text: "Funkcja dostępna wkrótce")
            }) {
                IconView(name: Icons.calendar, size: .medium, weight: .regular, color: Colors.main)
                .frame(width: 30, height: 40, alignment: .center)
            }
            
        }
        .frame(width: 80, height: 40, alignment: .leading)
        .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}
