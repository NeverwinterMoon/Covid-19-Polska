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
    var section1Height = (ChartView.height)*2
    
    @State var showConfirmedCases: Bool = false
    @State var hideConfirmedCases: Bool = true
    
    var body: some View {
        ZStack {
            Colors.appBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                VerticalSpacer()
                TitleView(title: "Covid-19 Polska", lastUpdateTime: vm.getLastUpdateDate(), parameterSumValue: vm.getConfirmedCases(), parameterIcon: Icons.confirmed, parameterIncreaseValue: vm.getLatestIncrease(), rightButtonIcon: Icons.dismiss) {
                    self.showDetailsView.toggle()
                    print("hideConfirmedCases")
                }
                VerticalSpacer()
                VerticalSpacer()
                List {
                    ExpandableLineView(title: "Zakażenia", show: $showConfirmedCases)
                    VStack {
                        ChartView(chartData: self.vm.getDailyChangeData(), title: "Dzienny przyrost", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                        ChartView(chartData: self.vm.getDailyIncreaseData(), title: "Zakażenia łącznie", minX: self.vm.getMinDate(), maxX: self.vm.getMaxDate())
                    }
                    
                        .opacity(self.showConfirmedCases ? 1.0 : 0.0)
                        .frame(height: self.showConfirmedCases ? section1Height : -section1Height)
                    //    .animation(.spring(response: 2.0, dampingFraction: 0.80, blendDuration: 0.8), value: self.showConfirmedCases)
                      //  .animation(.easeInOut(duration: 0.15))
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    
             //       ExpandableLineView(title: "Zgony", show: $showConfirmedCases)
             //       ExpandableLineView(title: "Wyleczeni", show: $showConfirmedCases)
             //       ExpandableLineView(title: "Województwa", show: $showConfirmedCases)
             //       ExpandableLineView(title: "Statystyki globalne", show: $showConfirmedCases)
                }.environment(\.defaultMinListRowHeight, 1)
                    .background(Colors.customViewBackground)
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
                IconView(name: Icons.expand, size: .medium, weight: .semibold, color: Colors.main)
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
