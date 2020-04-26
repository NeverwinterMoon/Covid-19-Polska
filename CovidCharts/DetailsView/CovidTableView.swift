//
//  CovidTableView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 21/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ParameterText: View {
    var title: String
    var body: some View {
        Text(title)
            .font(Fonts.indicatorTextBolded)
            .foregroundColor(Colors.label)
            .multilineTextAlignment(.center)
            .frame(width: UIScreen.width/10)
            
    }
}

struct ParameterColumn: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var parameter: ParameterType
    
    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .center) {
                ForEach(vm.dailyData.reversed(), id: \.self) { day in
                    ParameterText(title: self.getString(day))
                    .padding(.vertical, 4)
                }
            }
            Spacer()
        }
        .background(Colors.customViewBackground)
        
    }
    
    func getString(_ day: DailyData) -> String {
        switch parameter {
        case .confirmed: return String(day.confirmed)
        case .deaths: return String(day.deaths)
        case .recovered: return String(day.recovered)
        case .date: return String(day.date.formattedDate(.short))
        case .confirmedInc: return String(day.confirmedInc)
        case .deathsInc: return String(day.deathsInc)
        case .recoveredInc: return String(day.recoveredInc)
        }
    }
}

