//
//  ChartBottomView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartBottomView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        VStack (spacing: 4){
            ChartLineSpacer()
            HStack {
                ChartSmallText(text: "\(vm.customData.first?.date.formattedDate() ?? "")")
                Spacer()
                ChartSmallText(text: "\(vm.customData.last?.date.formattedDate() ?? "")")
            }
        }
        .padding(.horizontal)
    }
}
