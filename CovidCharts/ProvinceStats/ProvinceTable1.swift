//
//  ProvinceTable1.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 30/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ProvinceTable1: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack (spacing: 0) {
            
            ProvinceTable1FirstLine()
            
            ForEach(vm.regionData, id: \.self) { province in
                HStack (spacing: 0) {
                    Text(province.title.capitalized)
                        .padding(.vertical, 3)
                        .frame(width:150)
                        .padding(.vertical, 3)
                    Text("\(Int(province.value1))")
                        .padding(.vertical, 3)
                        .frame(width: 74)
                        .padding(.vertical, 3)
                    Text("\(Int(province.value2))")
                        .padding(.vertical, 3)
                        .frame(width: 74)
                        .padding(.vertical, 3)
                    Text(String(format: "%.2f", Double((province.value2/province.value1)*100)))
                        .padding(.vertical, 3)
                        .frame(width: 74)
                }
                .lineLimit(0)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(Colors.label)
            }
            
        }
    }
}

struct ProvinceTable1_Previews: PreviewProvider {
    static var previews: some View {
        ProvinceTable1().environmentObject(ChartViewModel())
    }
}


struct ProvinceTable1FirstLine: View {
    
    
    var body: some View {
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
            .frame(width: 74)
            VStack {
                Text("Liczba")
                Text("zgonów")
                
            }
            .padding(.vertical, 3)
            .frame(width: 74)
            VStack {
                Text("Procent")
                Text("zgonów")
            }
            .padding(.vertical, 3)
            .frame(width: 74)
            
        }
        .lineLimit(0)
        .font(.system(size: 12, weight: .semibold, design: .rounded))
        .foregroundColor(Colors.chartTop)
    }
}
