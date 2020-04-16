//
//  TitleView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading, spacing: 0) {
                Text("Covid-19 Polska")
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .foregroundColor(Color(UIColor.label))
                    .padding(.leading, 32)
                HStack (alignment: .center, spacing: 0) {
                    IconView(name: Images.time, size: .medium, color: Color(UIColor.systemPink))
                    Text("\(getCurrentDate())")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(UIColor.systemGray5))
                    Spacer()
                }
                .padding(.leading, 26.0)
            }
            .frame(width: 280, height: 90)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            Spacer()
            IconView(name: Images.reload, size: .large, color: Color(UIColor.label))
                .padding(.trailing)
                .onTapGesture {
                    self.vm.loadData()
            }
            .frame(width: 90, height: 90, alignment: .center)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            
        }
        .frame(width: UIScreen.screenWidth + 32, height: 90)
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "pl_PL")
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView().environmentObject(ChartViewModel())
    }
}
