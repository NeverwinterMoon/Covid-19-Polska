//
//  HomeStatisticsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 28/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    var icon: String
    var titles: [String]
    var values: [Int]
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                HStack {
                    Text(titles[0] + " \(values[0])")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    Spacer()
                }
                .padding(.leading, 70)
                HStack {
                    Text(titles[1] + " \(values[1])")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                    Spacer()
                }
                .padding(.leading, 70)
                HStack {
                    Text(titles[2] + " \(values[2])")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    Spacer()
                }
                .padding(.leading, 70)
            }
            .frame(width: 200, height: 65, alignment: .center)
                .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                .offset(x: 80)
            IconView(name: icon, size: .large, weight: .semibold, color: Colors.customViewBackground)
            .frame(width: 80, height: 80, alignment: .center)
            .background(Colors.chartTop)
            .clipShape(Circle())
            .shadow(color: Colors.chartTop.opacity(0.7), radius: 8, x: -4, y: 8)
        }.offset(x: -100)
    }
}

struct HomeStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisticsView(icon: Icons.sum, titles: ["Zakażenia:", "Zgony", "Wyleczeni"], values: [12312, 123, 2323])
    }
}
