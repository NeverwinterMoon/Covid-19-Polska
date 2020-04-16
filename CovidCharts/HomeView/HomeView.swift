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
    
    @ObservedObject var vm = ChartViewModel()
   
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 24) {
                TitleView(vm: vm)
                .padding(.top)
                VStack (alignment: .center, spacing: 8) {
                    ChartView(vm: vm)
                    Spacer()
                    MenuView(vm: vm)
                }
            }
            .padding(.top, 16)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
