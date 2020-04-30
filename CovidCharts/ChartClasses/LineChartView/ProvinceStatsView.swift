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
    @Binding var showProvinceStats: Bool
    
    var population = [2865000, 2055000, 2121000, 1003000, 2476000, 3395000, 5392000, 988000, 2129000, 1184000, 2324000, 4548000, 1244000, 1431000, 3490000, 1703000]
    
    
    var max: Double {
        return vm.regionData.max { (region1, region2) -> Bool in
            return region2.value1 > region1.value1
        }?.value1 ?? 0
    }
    
    func setHeight(_ value: Double) -> CGFloat {
        let heightMultiplier = CGFloat(value/self.max)
        return CGFloat((UIScreen.height/4)) * heightMultiplier
    }
    
    func setProvinceShort(title: String) -> String {
        var province: String = ""
        switch title {
            case "dolnoslaskie": province = "DŚ"
            case "kujawsko-pomorskie": province = "KP"
            case "lubelskie": province = "LB"
            case "lubuskie": province = "LS"
            case "lodzkie": province = "ŁD"
            case "malopolskie": province = "MP"
            case "mazowieckie": province = "MZ"
            case "opolskie": province = "OP"
            case "podkarpackie": province = "PK"
            case "podlaskie": province = "PL"
            case "pomorskie": province = "PM"
            case "slaskie": province = "ŚL"
            case "swietokrzyskie": province = "ŚK"
            case "warminsko-mazurskie": province = "WM"
            case "wielkopolskie": province = "WP"
            case "zachodniopomorskie": province = "ZP"
        default: break
        }
        return province
    }
    
    var body: some View {
        ZStack {
            Colors.background
            VStack {
                
                // Title bar
                
                HStack {
                    Button(action: {
                        self.showProvinceStats.toggle()
                    }) {
                        IconView(name: Icons.hide, size: .medium, weight: .regular, color: Colors.chartTop)
                    }
                    .frame(width: 50, height: 40)
                    .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                    Text("Województwa")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(Colors.label)
                    .padding(.leading, 8)
                    Spacer()
                }
                .padding(.top, 16)
                
                // Bar chart
                
                ScrollView (.vertical, showsIndicators: false) {
                   // Spacer()
                    SectionTitle(title: "Wykres zakażenia / zgony")
                    HStack {
                            VStack {
                                BarChartElement(text: "\(Int(self.max*1.0))")
                                Spacer()
                                BarChartElement(text: "\(Int(self.max*0.75))")
                                Spacer()
                                BarChartElement(text: "\(Int(self.max*0.5))")
                                Spacer()
                                BarChartElement(text: "\(Int(self.max*0.25))")
                                Spacer()
                                BarChartElement(text: "\(Int(self.max*0.0))")
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
                                                BarChartElement(text: "\(Int(province.value1))")
                                                Spacer()
                                                    .frame(width: UIScreen.width/10, height: self.setHeight(province.value1), alignment: .center)
                                                    .background(RoundedCorners(color: Colors.chartTop, tl: 8, tr: 8, bl: 0, br: 0))
                                                    .shadow(color: Colors.chartTop.opacity(0.3), radius: 5, x: 4, y: -2)
                                            }
                                                VStack {
                                                    BarChartElement(text: "\(Int(province.value2))")
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
                    
                    // Bar chart legend
                    
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
                    
                    SectionTitle(title: "Tabela zakażenia / zgony")
                    
                    // Table 1
                    
                    VStack (spacing: 0) {
                        
                        HStack (spacing: 0) {
                            VStack {
                             Text("Województwo")
                            }
                            .padding(.vertical, 3)
                            .frame(width:150)
                            VStack {
                              Text("Liczba")
                                Text("zakażeń")

                            }
                            .padding(.vertical, 3)
                            .frame(width: 60)
                            VStack {
                              Text("Liczba")
                                Text("zgonów")

                            }
                            .padding(.vertical, 3)
                            .frame(width: 60)
                            VStack {
                              Text("Procent")
                                Text("zgonów")
                            }
                            .padding(.vertical, 3)
                            .frame(width: 60)
                            
                        }                                .lineLimit(0)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(Colors.label)
                        
                         ForEach(vm.regionData, id: \.self) { province in
                            HStack (spacing: 0) {
                                    Text(province.title.capitalized)
                                        .padding(.vertical, 3)
                                        .frame(width:150)
                                .padding(.vertical, 3)
                                    Text("\(Int(province.value1))")
                                        .padding(.vertical, 3)
                                        .frame(width: 60)
                                .padding(.vertical, 3)
                                    Text("\(Int(province.value2))")
                                        .padding(.vertical, 3)
                                        .frame(width: 60)
                                .padding(.vertical, 3)
                                    Text(String(format: "%.2f", Double((province.value2/province.value1)*100)))
                                        .padding(.vertical, 3)
                                    .frame(width: 60)
                                }
                                .lineLimit(0)
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Colors.label)
                        }
                        
                        
                        // Provinces
                   //     TableColumn()
                        
                        
                        // Confirmed
//                        Spacer()
//                        VStack (alignment: .center) {
//                            VStack {
//                               Text("Liczba")
//                               Text("zakażeń")
//                            }
//                                .padding(.vertical, 2)
//                            .lineLimit(0)
//                            .font(.system(size: 12, weight: .semibold, design: .rounded))
//                            .foregroundColor(Colors.chartTop)
//
//                            ForEach(vm.regionData, id: \.self) { (province) in
//                                HStack {
//                                    Text("\(Int(province.value1))")
//                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Colors.label)
//                                }
//                                .padding(.vertical, 2)
//                            }
//                        }
//
//                        // Deaths
//                        Spacer()
//                        VStack (alignment: .center) {
//                            VStack {
//                               Text("Liczba")
//                               Text("zgonów")
//                            }
//                                .padding(.vertical, 2)
//                            .lineLimit(0)
//                            .font(.system(size: 12, weight: .semibold, design: .rounded))
//                            .foregroundColor(Colors.chartTop)
//                            ForEach(vm.regionData, id: \.self) { (province) in
//                                HStack {
//                                    Text("\(Int(province.value2))")
//                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Colors.label)
//                                }
//                                .padding(.vertical, 2)
//                            }
//                        }
//
//                        // Percentage of deaths
//                        Spacer()
//                        VStack (alignment: .center) {
//                            VStack {
//                               Text("Odsetek")
//                               Text("zgonów")
//                            }
//                                .padding(.vertical, 2)
//                            .lineLimit(0)
//                            .font(.system(size: 12, weight: .semibold, design: .rounded))
//                            .foregroundColor(Colors.chartTop)
//                            ForEach(vm.regionData, id: \.self) { (province) in
//                                HStack {
//                                    Text(String(format: "%.2f", Double((province.value2/province.value1)*100)))
//                                //    Text("\(Double((province.value2/province.value1)*100))")
//                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Colors.label)
//                                }
//                                .padding(.vertical, 2)
//                            }
//                        }
                        
//                        // Infections per 100 000
//
//                        VStack (alignment: .center) {
//                            Text("Liczba zakażeń na\n100 tys.\nmieszkańców")
//                            .font(.system(size: 12, weight: .semibold, design: .rounded))
//                            .foregroundColor(Colors.label)
//                            ForEach(0..<self.vm.regionData.count) {
//                                    Text(String(format: "%.2f", (self.vm.regionData[$0].value1/Double(self.population[$0])*100000)))
//                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Colors.label)
//                            }
//                        }
//
//                        // Deaths per 100 000
//                        VStack (alignment: .center) {
//                            Text("Liczba zgonów na\n100 tys. mieszkańców")
//                            .font(.system(size: 12, weight: .semibold, design: .rounded))
//                            .foregroundColor(Colors.label)
//                            ForEach(0..<self.vm.regionData.count) {
//                                    Text(String(format: "%.2f", (self.vm.regionData[$0].value2/Double(self.population[$0])*100000)))
//                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Colors.label)
//                            }
//                        }
                        
                    }//.padding(.all)
                    
                    
                    
                    
                    
                    Spacer()
                    
                }
            }
        }
    }
}

struct ProvinceStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProvinceStatsView(showProvinceStats: .constant(true)).environmentObject(ChartViewModel())
    }
}

struct BarChartElement: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(Colors.label)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
    }
}

struct TableColumn: View {
    
    @EnvironmentObject var vm: ChartViewModel
    var titleLine1: String
    var titleLine2: String
    
    var body: some View {
        VStack  (alignment: .center) {
            VStack {
                Text("Województwo")
                Text(" ")
            }
            .padding(.vertical, 3)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .foregroundColor(Colors.chartTop)
            
            ForEach(vm.regionData, id: \.self) { (province) in
                HStack {
                    Text("\(province.title.capitalized)")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(Colors.label)
                }.padding(.vertical, 3)
            }
        }
    }
}

struct SectionTitle: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .foregroundColor(Colors.label)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
            Spacer()
        }.padding(.vertical, 16)
    }
}
