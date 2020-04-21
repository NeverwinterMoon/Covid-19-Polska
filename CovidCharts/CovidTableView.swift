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
        ZStack {
            Colors.appBackground
            VStack {
                HStack (spacing: 0){
                    ParameterColumn(column: .date)
                    ParameterColumn(column: .confirmed)
                    ParameterColumn(column: .confirmedIncrease)
                    ParameterColumn(column: .deaths)
                    ParameterColumn(column: .deathsIncrease)
                    ParameterColumn(column: .recovered)
                    ParameterColumn(column: .recoveredIncrease)
                }
                .frame(width: UIScreen.width)
            }
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
        }
        
    }
}

struct CovidTableView_Previews: PreviewProvider {
    static var previews: some View {
        CovidTableView().environmentObject(ChartViewModel())
    }
}

fileprivate struct ParameterValueView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(Fonts.indicatorTextBolded)
            .multilineTextAlignment(.center)
    }
}

struct ParameterColumn: View {
    
    enum Column {
    case date, confirmed, confirmedIncrease, deaths, deathsIncrease, recovered, recoveredIncrease
    }
    
    @EnvironmentObject var vm: ChartViewModel
    
    var column: Column
    
    var body: some View {
        VStack {
            IconView(name: icon, size: .medium, weight: .semibold, color: Colors.main)
            .padding(.vertical, 8)
            .frame(width: UIScreen.width/7, alignment: .center)
            ForEach(vm.customData.reversed(), id: \.self) { day in
                ParameterValueView(title: self.getString(day))
            }
        }
    }
    
    var icon: String {
        switch column {
        case .date: return Icons.calendar
        case .confirmed: return Icons.confirmed
        case .deaths: return Icons.deaths
        case .recovered: return Icons.recovered
        default: return Icons.increase
        }
    }
    
    func getString(_ day: Day) -> String {
        
        switch column {
        case .confirmed: return String(day.confirmed)
        case .deaths: return String(day.deaths)
        case .recovered: return String(day.recovered)
        case .date: return String(day.date.formattedDate(.short))
        default: return "nil"
        }
    }
}
