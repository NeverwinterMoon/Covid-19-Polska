//
//  ContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 13/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var barChartViewModel: ChartViewModel
    @State var showPopup: Bool = false
    @State var bottomState: CGSize = .zero
    @State var showFull: Bool = false
    @State var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 0) {
                HomeViewTitleView()
                VerticalSpacer()
                ChartView()
                VerticalSpacer()
                ChartToolbar(showDetailsView: $showDetailsView, showPopup: $showPopup)
                Spacer()
                ToolbarView()
            }
            .blur(radius: showPopup ? 10 : 0)
            InfoPopupView(title: "Kalendarz", message: "Funkcja dostępna wkrótce", showPopup: $showPopup)
                .scaleEffect(showPopup ? 1.0 : 0.5)
                .opacity(showPopup ? 1.0 : 0.0)
                .animation(.spring())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ChartViewModel())
    }
}
