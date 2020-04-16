//
//  ChartSideView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartSideView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                ChartSmallText(text: "\(vm.getAllCases()/1)")
                Spacer()
                ChartSmallText(text: "\(vm.getAllCases()/2)")
                Spacer()
                ChartSmallText(text: "0")
            }
            Spacer()
        }
        .offset(x: 8, y: -8)
    }
    
}

struct ChartSideView_Previews: PreviewProvider {
    static var previews: some View {
        ChartSideView(vm: ChartViewModel())
    }
}
