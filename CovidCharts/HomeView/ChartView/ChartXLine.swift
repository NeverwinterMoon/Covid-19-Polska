//
//  ChartBottomView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartXLine: View {
    
    var minX: String
    var maxX: String
    
    var body: some View {
        VStack (spacing: 4){
            ChartLineSpacer()
            HStack {
                Text(minX)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(Colors.label)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(maxX)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(Colors.label)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.horizontal)
    }
}

struct ChartBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ChartXLine(minX: "2 March 2019", maxX: "9 March 2019")
    }
}
