//
//  TitleView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading, spacing: 0) {
                Text("Covid-19 Polska")
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .padding(.leading)
                HStack (alignment: .center, spacing: 0) {
                    IconView(name: "clock", size: .medium, color: Colors.lightBlue)
                    Text("\(getCurrentDate())")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.8705882353, alpha: 1)))
                    Spacer()
                }
                .padding(.leading, 10.0)
            }
            Spacer()
            IconView(name: "arrow.clockwise", size: .large, color: Colors.lightBlue)
                .padding(.trailing)
                .onTapGesture {
                    self.vm.loadData()
            }
            
        }
        .frame(width: UIScreen.screenWidth-32, height: 80)
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

struct IconView: View {
    var name: String
    var size: Image.Scale
    var color: Color
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .regular))
            .imageScale(size)
            .frame(width: 32, height: 32)
            .foregroundColor(color)
    }
}
