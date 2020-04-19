//
//  ChartView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
                .background(Color.clear)
            ChartTopView()
            Spacer()
                 .frame(width: UIScreen.width, height: 8, alignment: .center)
            ChartContentView()
                .padding(.leading, 2)
            ChartBottomView()
                .padding(.horizontal)
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
                .background(Color.clear)
        }
        .frame(width: UIScreen.width+32, height: UIScreen.height/1.75)
        .background(Colors.customViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView().environmentObject(ChartViewModel())
    }
}
