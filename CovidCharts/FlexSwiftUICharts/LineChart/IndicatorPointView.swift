//
//  IndicatorPointView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 17/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Colors.main)
            Circle()
                .stroke(Colors.appBackground, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
