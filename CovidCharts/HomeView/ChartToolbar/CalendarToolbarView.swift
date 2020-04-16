//
//  CalendarToolbarView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct CalendarToolbar: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center, spacing: 2) {
            CalendarButton()
            CalendarToolbarSpacer()
            CustomDateButton(days: 7)
            CalendarToolbarSpacer()
            CustomDateButton(days: 30)
        }
        .frame(width: 170, height: 40, alignment: .leading)
        .padding(.leading, 24)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

struct CalendarToolbar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarToolbar().environmentObject(ChartViewModel())
    }
}

private struct CalendarButton: View {
    var body: some View {
        Button(action: {
            print("Calendar tapped")
        }) {
            IconView(name: Images.calendar, size: .medium, color: Color(UIColor.systemPink))
        }
        .frame(width: 40, height: 40, alignment: .center)
    }
}

private struct CustomDateButton: View {
    
    @EnvironmentObject var vm: ChartViewModel
    var days: Int
    
    var body: some View {
        Button(action: {
            print(self.days)
            
        }) {
            Text("\(days) dni")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(UIColor.label))
        }
        .frame(width: 50, height: 40, alignment: .center)
    }
}

private struct CalendarToolbarSpacer: View {
    var body: some View {
        Spacer()
            .frame(width: 1, height: 20, alignment: .center)
            .background(Color(UIColor.label))
    }
}
