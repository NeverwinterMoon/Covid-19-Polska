//
//  ChartBottomView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartBottomView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack (spacing: 4){
            ChartLineSpacer()
            HStack {
                ChartSmallText(text: "\(vm.customData.first?.date ?? "")")
                Spacer()
                ChartSmallText(text: "\(vm.customData.last?.date ?? "")")
            }
        }
        .padding(.horizontal)
    }
}

struct ChartBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ChartBottomView().environmentObject(ChartViewModel())
    }
}
