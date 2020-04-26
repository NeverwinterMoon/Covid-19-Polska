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
    @Binding var showPopup: Bool
    @State var showDetailsMenuView: Bool = false
    @State var chartBottom: CGFloat = 0
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 0) {
                if !vm.dailyData.isEmpty {
                    
                    HomeTopView(title: "Covid-19 Polska", lastUpdateTime: vm.getLatestDate(.superlong), parameterSumValue: String(vm.getLatest(.confirmed)), parameterIcon: Icons.confirmed, parameterIncreaseValue: String(vm.getLatest(.confirmedInc)), rightButtonIcon: Icons.reload) {
                        self.vm.loadData()
                    }
                    VerticalSpacer()
                    ChartView(data: vm.getData(vm.parameter), title: vm.chartTitle, minX: vm.minDate, maxX: vm.maxDate)
                    VerticalSpacer()
                    HomeChartToolbarView(showDetailsView: $showDetailsMenuView, showPopup: $showPopup)
                        .opacity(vm.showHighlightedData ? 0 : 1)
                        .animation(.easeInOut)
                    Spacer()
                    HomeBotView()
                    .opacity(vm.showHighlightedData ? 0 : 1)
                    .animation(.easeInOut)
                }
                else {
                    VStack (spacing: 40) {
                        ActivityIndicator()
                            .frame(width: 60, height: 60, alignment: .center)
                        Text("Ładowanie danych...")
                            .font(Fonts.popupTitle)
                            .foregroundColor(Colors.main)
                    }
                    .foregroundColor(Colors.main)
                }
            }
            .blur(radius: self.vm.showPopup ? 10 : 0)
            .blur(radius: self.showDetailsMenuView ? 10 : 0)
            InfoPopupView(title: vm.popup.title, message: vm.popup.text)
                .scaleEffect(self.vm.showPopup ? 1.0 : 0.5)
                .opacity(self.vm.showPopup ? 1.0 : 0.0)
                .animation(.spring())
            GeometryReader { (geometry) in
                HomeChartDetailsView()
                    .offset(x: 0, y: self.vm.showHighlightedData ? 0 : geometry.size.height)
                    .animation(.spring())
            }
            GeometryReader { (geometry) in
                DetailsMenuView(showDetailsMenuView: self.$showDetailsMenuView)
                    .offset(x: 0, y: self.showDetailsMenuView ? 0 : geometry.size.height)
                    .animation(.spring())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showPopup: .constant(false)).environmentObject(ChartViewModel())
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
