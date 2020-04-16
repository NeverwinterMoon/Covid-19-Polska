//
//  ContentView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 13/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

enum ChartType {
    case deaths, confirmed, recovered
}

struct HomeView: View {
    
    @EnvironmentObject var vm: ChartViewModel
   
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 16) {
                TitleView(vm: vm)
                .padding(.top)
                ChartView(vm: vm)
                ChartToolbar(vm: vm)
                ToolbarView(vm: vm)
                .padding(.bottom, 8)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ChartViewModel())
    }
}
