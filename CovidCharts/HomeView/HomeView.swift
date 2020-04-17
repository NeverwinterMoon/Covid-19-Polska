//
//  ContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 13/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    @State var showLineChart: Bool = false
   
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 16) {
                TitleView()
                .padding(.top)
                ChartView()
                ChartToolbar(showLineChart: $showLineChart)
                ToolbarView()
                .padding(.bottom, 8)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showLineChart: false).environmentObject(ChartViewModel())
    }
}
