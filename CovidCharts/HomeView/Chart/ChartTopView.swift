//
//  ChartTopView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartTopView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        VStack (spacing: 4) {
            Text(vm.getTitle())
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Color(UIColor.label))
                .frame(width: 250)
            VStack (alignment: .center, spacing: 0) {
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: UIScreen.screenWidth - 32, height: 1)
            .background(Color(UIColor.label))
            Text(String(vm.getAllCases()))
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(Color(UIColor.label))
        }
    }
    
}
