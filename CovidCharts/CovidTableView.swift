//
//  CovidTableView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 21/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct CovidTableView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
            VStack {
                Text("Tabela Covid-19 Polska")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Colors.label)
                    .frame(width: 250)
                VStack (alignment: .center, spacing: 0) {
                    Spacer()
                }
                .padding(.horizontal)
                .frame(width: UIScreen.width - 32, height: 1)
                .background(Colors.label)
                HStack (spacing: 0){
                    ParameterColumn(column: .date, icon: Icons.calendar, data: vm.customData)
                    ParameterColumn(column: .confirmed, icon: Icons.confirmed, data: vm.customData)
                    ParameterColumn(column: .confirmed, icon: Icons.increase, data: vm.customIncreaseData)
                    ParameterColumn(column: .deaths, icon: Icons.deaths, data: vm.customData)
                    ParameterColumn(column: .deaths, icon: Icons.increase, data: vm.customIncreaseData)
                    ParameterColumn(column: .recovered, icon: Icons.recovered, data: vm.customData)
                    ParameterColumn(column: .recovered, icon: Icons.increase, data: vm.customIncreaseData)
                }
                .frame(width: UIScreen.width)
            }
            .padding(.vertical, 8)
            .background(Colors.customViewBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                        .background(Colors.customViewBackground)
        
    }
}

struct CovidTableView_Previews: PreviewProvider {
    static var previews: some View {
        CovidTableView().environmentObject(ChartViewModel())
    }
}

struct ParameterText: View {
    var title: String
    var body: some View {
        Text(title)
            .font(Fonts.indicatorTextBolded)
            .foregroundColor(Colors.label)
            .multilineTextAlignment(.center)
        .frame(height: 24)
    }
}

struct ParameterColumn: View {
    
    enum Column {
    case date, confirmed, deaths, recovered
    }

    var column: Column
    var icon: String
    var data: [Day]
    
    var body: some View {
        VStack {
            IconView(name: icon, size: .medium, weight: .semibold, color: Colors.main)
            .padding(.vertical, 8)
            .frame(width: UIScreen.width/7, alignment: .center)
            ForEach(data.reversed(), id: \.self) { day in
                ParameterText(title: self.getString(day))
                .padding(2)
            }
        }.padding(.vertical, 8)
    }
    
    func getString(_ day: Day) -> String {
        switch column {
        case .confirmed: return String(day.confirmed)
        case .deaths: return String(day.deaths)
        case .recovered: return String(day.recovered)
        case .date: return String(day.date.formattedDate(.short))
        }
    }
}

