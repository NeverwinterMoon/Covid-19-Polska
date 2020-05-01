//
//  ProvinceStatsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 29/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ProvinceStatsView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @Binding var showView: Bool
    @State var showInfo: Bool = false
    
    var body: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            VStack {
                DetailsTitleBar(title: "Województwa", showView: $showView, showInfo: $showInfo)
                .padding(.top, 16)
                ScrollView (.vertical, showsIndicators: false) {
                    SectionTitle(title: "Wykres zakażenia / zgony", icon: Icons.bars)
                    ProvinceBarChart()
                    BarChartLegend()
                    SectionTitle(title: "Tabela 1: Ogólne", icon: Icons.table)
                    ProvinceTable1()
                    SectionTitle(title: "Tabela 2: Szczegóły", icon: Icons.table)
                    ProvinceTable2()
                    Spacer()
                    
                }
                Spacer()
            }
            .blur(radius: self.showInfo ? 10 : 0)
            InfoPopupView(showView: $showInfo, title: vm.popup.title, message: vm.popup.text)
            .scaleEffect(self.showInfo ? 1.0 : 0.5)
            .opacity(self.showInfo ? 1.0 : 0.0)
            .animation(.spring())
        }
    }
}

struct ProvinceStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProvinceStatsView(showView: .constant(true)).environmentObject(ChartViewModel())
    }
}

struct DetailsText: View {
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
    }
}

struct SectionTitle: View {
    
    var title: String
    var icon: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(title)
                    .foregroundColor(Colors.label)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .padding(.trailing, 16)
                    .padding(.leading, 28)
                    .padding(.vertical, 8)
                    .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 16, bl: 16, br: 16))
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                Spacer()
            }
            .offset(x: 70)

            HStack {
                IconView(name: icon, size: .medium, weight: .semibold, color: Colors.customViewBackground)
                .frame(width: 60, height: 60, alignment: .center)
                .padding(.vertical, 8)
                .background(Colors.chartTop)
                .clipShape(Circle())
                    .shadow(color: Colors.chartTop.opacity(0.7), radius: 8, x: -4, y: 8)
                Spacer()
            }
        .offset(x: 30)
  
        }
        
    }
}

struct BarChartLegend: View {
    var body: some View {
        HStack {
            Spacer()
            HStack (spacing: 24) {
                HStack (spacing: 8){
                    Text("Zakażenia")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Colors.label)
                    Spacer()
                        .frame(width: 32, height: 4, alignment: .center)
                        .background(RoundedCorners(color: Colors.chartTop, tl: 8, tr: 8, bl: 8, br: 8))
                }
                HStack (spacing: 8){
                    Text("Zgony")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Colors.label)
                    Spacer()
                        .frame(width: 32, height: 4, alignment: .center)
                        .background(RoundedCorners(color: Colors.chartBot, tl: 8, tr: 8, bl: 8, br: 8))
                }
            }
            Spacer()
        }
    }
}

struct ProvinceBarChart: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var max: Double {
        return vm.regionData.max { (region1, region2) -> Bool in
            return region2.value1 > region1.value1
        }?.value1 ?? 0
    }
    
    func setHeight(_ value: Double) -> CGFloat {
        let heightMultiplier = CGFloat(value/self.max)
        return CGFloat((UIScreen.height/4)) * heightMultiplier
    }
    
    var body: some View {
        HStack {
            VStack {
                DetailsText(text: "\(Int(self.max*1.0))", color: Colors.label)
                Spacer()
                DetailsText(text: "\(Int(self.max*0.75))", color: Colors.label)
                Spacer()
                DetailsText(text: "\(Int(self.max*0.5))", color: Colors.label)
                Spacer()
                DetailsText(text: "\(Int(self.max*0.25))", color: Colors.label)
                Spacer()
                DetailsText(text: "\(Int(self.max*0.0))", color: Colors.label)
                Spacer()
                    .frame(height: 12, alignment: .center)
            }
            .padding(.horizontal, 6)
            ScrollView (.horizontal, showsIndicators: false) {
                HStack (alignment: .bottom, spacing: 16) {
                    ForEach(vm.regionData, id: \.self) { (province) in
                        VStack (alignment: .center, spacing: 4) {
                            HStack (alignment: .bottom) {
                                VStack {
                                    DetailsText(text: "\(Int(province.value1))", color: Colors.label)
                                    Spacer()
                                        .frame(width: UIScreen.width/10, height: self.setHeight(province.value1), alignment: .center)
                                        .background(RoundedCorners(color: Colors.chartTop, tl: 8, tr: 8, bl: 0, br: 0))
                                        .shadow(color: Colors.chartTop.opacity(0.3), radius: 5, x: 4, y: -2)
                                }
                                VStack {
                                    DetailsText(text: "\(Int(province.value2))", color: Colors.label)
                                    Spacer()
                                        .frame(width: UIScreen.width/10, height: self.setHeight(province.value2), alignment: .center)
                                        .background(RoundedCorners(color: Colors.chartBot, tl: 8, tr: 8, bl: 0, br: 0))
                                        .shadow(color: Colors.chartBot.opacity(0.3), radius: 5, x: 4, y: -2)
                                }
                            }
                            .padding(.top, 8)
                            Text(province.title.capitalized)
                                .font(.system(size: 8, weight: .semibold, design: .rounded))
                                .foregroundColor(Colors.label)
                                .frame(height: 20, alignment: .center)
                        }
                    }
                }
                
            }
        }
    }
}
