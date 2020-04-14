//
//  ChartCustomClasses.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartSmallText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .regular, design: .default))
            .foregroundColor(Colors.lightBlue)
    }
}

struct ChartLineSpacer: View {
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: UIScreen.screenWidth - 32, height: 1)
        .background(Colors.lightBlue)
    }
}
