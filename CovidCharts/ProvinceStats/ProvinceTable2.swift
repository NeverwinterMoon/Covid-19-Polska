//
//  ProvinceTable2.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 30/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ProvinceTable2: View {
    
    @EnvironmentObject var vm: ChartViewModel
    var population = [2865000, 2055000, 2121000, 1003000, 2476000, 3395000, 5392000, 988000, 2129000, 1184000, 2324000, 4548000, 1244000, 1431000, 3490000, 1703000]
    
    enum Table2Parameter {
        case per100, percent
    }
    
    func getValue(value: Double, population: Int, param: Table2Parameter) -> String {
        switch param {
        case .per100: return String(format: "%.2f", (value/Double(population))*100000)
        case .percent: return String(format: "%.2f", (value/Double(population))*100)
        }
    }
    
    var body: some View {
        VStack (spacing: 0) {
            
            ProvinceTable2FirstLine()
            
            ForEach(0..<self.vm.regionData.count) { number in
                HStack (spacing: 0) {
                    Text(self.vm.regionData[number].title.capitalized)
                        .padding(.vertical, 3)
                        .frame(width:150)
                        .padding(.vertical, 3)
                    Text(self.getValue(value: self.vm.regionData[number].value1, population: self.population[number], param: .per100))
                        .padding(.vertical, 3)
                        .frame(width: 74)
                        .padding(.vertical, 3)
                    Text(self.getValue(value: self.vm.regionData[number].value2, population: self.population[number], param: .per100))
                        .padding(.vertical, 3)
                        .frame(width: 74)
                        .padding(.vertical, 3)
                    Text(self.getValue(value: self.vm.regionData[number].value1, population: self.population[number], param: .percent))
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

struct ProvinceTable2_Previews: PreviewProvider {
    static var previews: some View {
        ProvinceTable2().environmentObject(ChartViewModel())
    }
}


struct ProvinceTable2FirstLine: View {
    
    
    var body: some View {
        HStack (spacing: 0) {
            VStack {
                Text("Województwo")
            }
            .padding(.vertical, 3)
            .frame(width:150)
            VStack {
                Text("Zakażenia")
                Text("na 100 tys.")
                
            }
            .padding(.vertical, 3)
            .frame(width: 74)
            VStack {
                Text("Zgony")
                Text("na 100 tys.")
                
            }
            .padding(.vertical, 3)
            .frame(width: 74)
            VStack {
                Text("Zakażony")
                Text("% populacji")
            }
            .padding(.vertical, 3)
            .frame(width: 74)
            
        }
        .lineLimit(0)
        .font(.system(size: 12, weight: .semibold, design: .rounded))
        .foregroundColor(Colors.main)
    }
}
