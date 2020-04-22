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
    
    var tableSectionHeight: CGFloat = 960
    
    @State var showConfirmedCharts: Bool = false
    @State var showDeathsCharts: Bool = false
    @State var showRecoveredCharts: Bool = false
    @State var showCovidTable: Bool = false
    @State var showProvinceChart: Bool = false
    
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
                List {
                    SectionTitle(title: "Zakażenia", show: $showConfirmedCharts)
                        .padding(.bottom)
                    SectionCharts(show: $showConfirmedCharts, parameter: .confirmed, title1: "Przyrost zakażeń", title2: "Zakażenia")
                    SectionTitle(title: "Zgony", show: $showDeathsCharts)
                        .padding(.vertical,8)
                    SectionCharts(show: $showDeathsCharts, parameter: .deaths, title1: "Przyrost zgonów", title2: "Zgony")
                    SectionTitle(title: "Wyzdrowienia", show: $showRecoveredCharts)
                        .padding(.vertical,8)
                    SectionCharts(show: $showRecoveredCharts, parameter: .recovered, title1: "Przyrost wyzdrowień", title2: "Wyzdrowienia")
                    SectionTitle(title: "Tabela zakażeń", show: $showCovidTable)
                        .padding(.vertical,8)
                    CovidTableView()
                        .opacity(self.showCovidTable ? 1.0 : 0.0)
                        .frame(height: self.showCovidTable ? tableSectionHeight : -tableSectionHeight)
                        .listRowBackground(Colors.appBackground)
                    SectionTitle(title: "Województwa", show: $showProvinceChart)
                    BarHorizontalChartView(title: "Zakażenia w województwach", data: vm.regionData, legend1: "Zakażenia", color1: Colors.main, legend2: "Zgony", color2: Colors.BorderBlue)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .listRowBackground(Colors.appBackground)
                }
                .environment(\.defaultMinListRowHeight, 1)
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

struct SectionTitle: View {
    
    var title: String
    @Binding var show: Bool
    
    var body: some View {
        HStack {
            HStack (spacing: 0) {
                Text(title)
                    .font(Fonts.titleListElement)
                    .padding(.trailing, 16)
                    .animation(.linear)
                    .padding(.leading, 16)
                IconView(name: Icons.collapse, size: .medium, weight: .semibold, color: Colors.main)
                    .padding(.leading,8)
                    .rotationEffect(.degrees(show ? 360 : 180))
                    .animation(.easeInOut)
            }
            .frame(height: 40)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            Spacer()
        }
        .onTapGesture {
                self.show.toggle()
        }
        .listRowBackground(Colors.appBackground)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct SectionCharts: View {
    
    @EnvironmentObject var vm: ChartViewModel
    var chartSectionHeight = (ChartView.height)*2+32
    
    @Binding var show: Bool
    
    var parameter: ParameterType
    var title1: String
    var title2: String
    
    var body: some View {
        VStack(spacing: 16) {
            ChartView(data: self.vm.getDailyChangeData(parameter), title: title1, minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
            ChartView(data: self.vm.getDailyIncreaseData(parameter), title: title2, minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
        }
        .opacity(self.show ? 1.0 : 0.0)
        .listRowBackground(Colors.appBackground)
        .frame(height: self.show ? chartSectionHeight : -chartSectionHeight)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
