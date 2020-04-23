//
//  BarIndicatorView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 22/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct BarIndicatorView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            IndicatorTitleView(title: "Hi", textColor: Colors.main)
            IndicatorTextLine(parameter: "Zakażenia", currentValue: 5)
            IndicatorTextLine(parameter: "Zgony", currentValue: 5)
            Spacer()
            .frame(height: 4)
            IndicatorTitleView(title: "Łącznie", textColor: Colors.main)
            IndicatorTextLine(parameter: "Zakażenia", currentValue: 5)
            IndicatorTextLine(parameter: "Zgony", currentValue: 5)
        }.frame(width: 150, height: 50, alignment: .center)
    }
}

struct BarIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        BarIndicatorView()
    }
}
