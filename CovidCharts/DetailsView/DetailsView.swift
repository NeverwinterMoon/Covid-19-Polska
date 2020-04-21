//
//  DetailsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 20/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showDetailsView: Bool
    
    @State var showConfirmedCases: Bool = false
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                VerticalSpacer()
                TitleView(title: "Covid-19 Polska", lastUpdateTime: vm.getLastUpdateDate(), parameterSumValue: vm.getConfirmedCases(), parameterIcon: Images.confirmed, parameterIncreaseValue: vm.getLatestIncrease(), rightButtonIcon: Images.reload) {
                    self.showDetailsView.toggle()
                }
                VerticalSpacer()
                VerticalSpacer()
                List {
                    ExpandableLineView(title: "Zakażenia", show: $showConfirmedCases)
                    ChartView(chartData: vm.getDailyChangeData(), title: "Dzienny przyrost", todayValue: vm.getTodayValue(), maxY: vm.getChartMaxValue(), midY: vm.getChartMidValue(), minX: vm.getMinDate(), maxX: vm.getMaxDate())
                        .frame(height: showConfirmedCases ? 550 : -550)
                        .opacity(showConfirmedCases ? 1.0 : 0.0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.80, blendDuration: 0.9), value: showConfirmedCases)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    ExpandableLineView(title: "Zgony", show: $showConfirmedCases)
                    ExpandableLineView(title: "Wyleczeni", show: $showConfirmedCases)
                    ExpandableLineView(title: "Województwa", show: $showConfirmedCases)
                    ExpandableLineView(title: "Statystyki globalne", show: $showConfirmedCases)
                }.environment(\.defaultMinListRowHeight, 1)
                .background(Colors.appBackground)
            }
        }

    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(showDetailsView: .constant(true)).environmentObject(ChartViewModel())
    }
}

struct ExpandableLineView: View {
    
    var title: String
    @Binding var show: Bool
    
    var body: some View {
        HStack {
            HStack (spacing: 0) {
                Text(title)
                    .font(Fonts.titleListElement)
                    .padding()
                    .animation(.linear)
                IconView(name: Images.expand, size: .medium, weight: .semibold, color: Colors.main)
                    .padding(.horizontal, 8)
                    .rotationEffect(.degrees(show ? 360 : 180))
                    .animation(.easeInOut)
            }
            .frame(height: 50)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            Spacer()
        }
        .onTapGesture {
                self.show.toggle()
        }
        .listRowBackground(Colors.appBackground)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0))
    }
}
