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
    
    var chartSectionHeight = (ChartView.height)*2
    
    @State var showConfirmedCharts: Bool = false
    @State var showDeathsCharts: Bool = false
    @State var showRecoveredCharts: Bool = false
    
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                VerticalSpacer()
                Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
                VerticalSpacer()
                HomeViewBottomView(title: "Covid-19 Polska", lastUpdateTime: vm.getLastUpdateDate(), parameterSumValue: vm.getConfirmedCases(), parameterIcon: Icons.confirmed, parameterIncreaseValue: vm.getLatestIncrease(), rightButtonIcon: Icons.dismiss) {
                    self.showDetailsView.toggle()
                    print("hideConfirmedCases")
                }
                VerticalSpacer()
                VerticalSpacer()
                List {
                    ExpandableLineView(title: "Zakażenia", show: $showConfirmedCharts)
                    VStack {
                        ChartView(data: self.vm.getDailyChangeData(.confirmed), title: "Dzienny przyrost", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                        ChartView(data: self.vm.getDailyIncreaseData(.confirmed), title: "Liczba zakażeń", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                    }
                        .opacity(self.showConfirmedCharts ? 1.0 : 0.0)
                        .frame(height: self.showConfirmedCharts ? chartSectionHeight : -chartSectionHeight)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    ExpandableLineView(title: "Zgony", show: $showDeathsCharts)
                    VStack {
                        ChartView(data: self.vm.getDailyChangeData(.deaths), title: "Przyrost", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                        ChartView(data: self.vm.getDailyIncreaseData(.deaths), title: "Liczba zgonów", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                    }
                        .opacity(self.showDeathsCharts ? 1.0 : 0.0)
                        .frame(height: self.showDeathsCharts ? chartSectionHeight : -chartSectionHeight)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    ExpandableLineView(title: "Wyleczeni", show: $showRecoveredCharts)
                    VStack {
                        ChartView(data: self.vm.getDailyChangeData(.recovered), title: "Przyrost", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                        ChartView(data: self.vm.getDailyIncreaseData(.recovered), title: "Liczba wyleczonych", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                    }
                        .opacity(self.showRecoveredCharts ? 1.0 : 0.0)
                        .frame(height: self.showRecoveredCharts ? chartSectionHeight : -chartSectionHeight)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
                IconView(name: Icons.collapse, size: .medium, weight: .semibold, color: Colors.main)
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
