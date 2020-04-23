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

    @State var showSection1: Bool = false
    @State var showSection2: Bool = false
    @State var showSection3: Bool = false
    @State var showSection4: Bool = false
    @State var showSection5: Bool = false

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
                HomeTopView(title: "Covid-19 Polska", lastUpdateTime: vm.getLastUpdateDate(), parameterSumValue: vm.getConfirmedCases(), parameterIcon: Icons.confirmed, parameterIncreaseValue: vm.getLatestIncrease(), rightButtonIcon: Icons.dismiss) {
                    self.showDetailsView.toggle()
                }
                VerticalSpacer()
                List {
                    Section(header: SectionTitle(title: "Zakażenia", show: $showSection1)) {
                        if showSection1 {
                             SectionCharts(parameter: .confirmed, title1: "Przyrost zakażeń", title2: "Zakażenia")
                                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
                        }
                    }
                            .listRowBackground(Color.clear)
                    Section(header: SectionTitle(title: "Zgony", show: $showSection2)) {
                        if showSection2 {
                             SectionCharts(parameter: .deaths, title1: "Przyrost zgonów", title2: "Zgony")
                        }
                    }
                    Section(header: SectionTitle(title: "Wyzdrowienia", show: $showSection3)) {
                        if showSection3 {
                             SectionCharts(parameter: .deaths, title1: "Przyrost wyzdrowień", title2: "Wyzdrowienia")
                        }
                    }
                            .listRowBackground(Color.clear)
                    Section(header: SectionTitle(title: "Tabela informacyjna", show: $showSection4)) {
                        if showSection4 {
                             CovidTableView()
                        }
                    }
                            .listRowBackground(Color.clear)
                    Section(header: SectionTitle(title: "Podział na województwa", show: $showSection5)) {
                        if showSection5 {
                            BarHorizontalChartView(title: "Zakażenia w województwach", data: vm.regionData, legend1: "Zakażenia", color1: Colors.main, legend2: "Zgony", color2: Colors.main2)
                        }
                    }
                            .listRowBackground(Color.clear)

                }
                .background(Colors.appBackground)
            }.frame(width: UIScreen.width+40)
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
        VStack {
                HStack {
                    HStack (spacing: 0) {
                        Text(title)
                            .font(Fonts.listSectionTitle)
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
                .padding(.vertical, 16)
                .onTapGesture {
                        self.show.toggle()
                    print("tapped: \(self.show)")
                }
                .listRowBackground(Colors.appBackground)
                .background(Colors.appBackground)
            }
        }

}

struct SectionCharts: View {
    
    @EnvironmentObject var vm: ChartViewModel
    var parameter: ParameterType
    var title1: String
    var title2: String
    
    var body: some View {
        VStack(spacing: 16) {
            ChartView(data: self.vm.getDailyChangeData(parameter), title: title1, minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
            ChartView(data: self.vm.getDailyIncreaseData(parameter), title: title2, minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
        .listRowBackground(Colors.appBackground)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
