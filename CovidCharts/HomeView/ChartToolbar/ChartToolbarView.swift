//
//  ChartToolbarView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartToolbar: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        HStack {
            CalendarToolbar()
            Spacer()
            ShowDetailsButton()
        }
        .frame(width: UIScreen.screenWidth + 32, height: 40, alignment: .center)
    }
    
}

struct ChartToolbar_Previews: PreviewProvider {
    static var previews: some View {
        ChartToolbar().environmentObject(ChartViewModel())
    }
}

struct CalendarToolbar: View {
    var body: some View {
        HStack (alignment: .center, spacing: 2) {
            CalendarButton()
            CalendarToolbarSpacer()
            CustomDateButton(days: 7)
            Spacer()
                .frame(width: 1, height: 20, alignment: .center)
                .background(Color(UIColor.label))
            CustomDateButton(days: 30)
        }
        .frame(width: 170, height: 40, alignment: .leading)
        .padding(.leading, 24)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

struct CalendarButton: View {
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
    
    var days: Int
    
    var body: some View {
        Button(action: {
            print(self.days)
            //  self.vm.getDataFromLast(7)
        }) {
            Text("\(days) dni")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(UIColor.label))
        }
        .frame(width: 50, height: 40, alignment: .center)
    }
}

private struct ShowDetailsButton: View {
    var body: some View {
        Button(action: {
            print("show")
        }) {
            Text("Pokaż szczegóły")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(UIColor.label))
                .padding(.trailing, 16)
        }
        .frame(width: 170, height: 40, alignment: .center)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

private struct CalendarToolbarSpacer: View {
    var body: some View {
        Spacer()
            .frame(width: 1, height: 20, alignment: .center)
            .background(Color(UIColor.label))
    }
}