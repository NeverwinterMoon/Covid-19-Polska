//
//  ChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(vm: ChartViewModel())
    }
}

struct ChartView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        VStack (alignment: .center, spacing: 8) {
            ChartTopView(vm: vm)
            
            ChartContentView(vm: vm)
            ChartBottomView(vm: vm)
        }
        .frame(width: UIScreen.screenWidth-16, height: UIScreen.screenHeight/1.75)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 6)
    }
    
}
