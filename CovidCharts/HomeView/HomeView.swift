//
//  ContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 13/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @State var showPopup: Bool = false
    @State var bottomState: CGSize = .zero
    @State var showFull: Bool = false
    @State var showDetailsView: Bool = false
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 0) {
                if !vm.customData.isEmpty {
                    TitleView(title: "Covid-19 Polska", lastUpdateTime: vm.getLastUpdateDate(), parameterSumValue: vm.getConfirmedCases(), parameterIcon: Images.confirmed, parameterIncreaseValue: vm.getLatestIncrease(), rightButtonIcon: Images.reload) {
                        print("Reload tapped")
                    }
                    VerticalSpacer()
                    ChartView(chartData: vm.getDailyChangeData(), title: vm.setChartTitle(vm.parameter), minX: vm.getMinDate(), maxX: vm.getMaxDate())
                    VerticalSpacer()
                    ChartToolbar(showDetailsView: $showDetailsView, showPopup: $showPopup)
                    Spacer()
                    ToolbarView()
                } else {
                    VStack (spacing: 40) {
                        ActivityIndicator()
                            .frame(width: 60, height: 60, alignment: .center)
                        Text("Ładowanie danych...")
                            .font(Fonts.titlePopup)
                            .foregroundColor(Colors.main)
                    }
                    .foregroundColor(Colors.main)
                }
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

struct ActivityIndicator: View {

  @State private var isAnimating: Bool = false

  var body: some View {

    GeometryReader { (geometry: GeometryProxy) in
      ForEach(0..<5) { index in
        Group {
          Circle()
            .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
            .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
            .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
        }.frame(width: geometry.size.width, height: geometry.size.height)
            .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
            .animation(Animation
                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                .repeatForever(autoreverses: false))
        }
    }.aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating.toggle()
    }
    .onDisappear {
        self.isAnimating.toggle()
    }
    }
    
}
