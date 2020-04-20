//
//  ChartYLine.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 18/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartYLine: View {
    
    var max: Double
    var mid: Double
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                HStack {
                    ChartSmallText(text: "\(Int(max))")
                    Spacer()
                }
                Spacer()
                HStack {
                    ChartSmallText(text: "\(Int(mid))")
                    .offset(x: 0, y: 10)
                    Spacer()
                }
                Spacer()
                HStack {
                    ChartSmallText(text: "")
                    Spacer()
                }
            }
            Spacer()
        }
        .offset(x: 12, y: -8)
    }
    
}

struct ChartSideView_Previews: PreviewProvider {
    static var previews: some View {
        ChartYLine(max: 20, mid: 10)
    }
}
