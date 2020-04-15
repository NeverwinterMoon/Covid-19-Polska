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
            Colors.darkBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack (alignment: .center, spacing: 8) {
                    TitleView(vm: vm)
                        .padding(.top)
                    ChartView(vm: vm)
                    Spacer()
                    MenuView(vm: vm)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                }
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct MenuView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            HStack (alignment: .center) {
                Spacer()
                MenuButton(title: "Zakażenia", image: Images.confirmed, showChart: .confirmed, vm: vm)
                MenuButton(title: "Zgony", image: Images.deaths, showChart: .deaths, vm: vm)
                Spacer()
            }
            Spacer()
            HStack (alignment: .center) {
                Spacer()
                MenuButton(title: "Wyleczeni", image: Images.recovered, showChart: .recovered, vm: vm)
                MenuButton(title: "Informacje", image: Images.info, showChart: .confirmed, vm: vm)
                Spacer()
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/4.5, alignment: .center)
    }
}

struct MenuIconView: View {
    var name: String
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .semibold))
            .imageScale(.large)
            .frame(width: 50, height: 50)
            .foregroundColor(Colors.mainColor)
    }
}

struct MenuButton: View {
    
    var title: String
    var image: String
    var showChart: ChartType
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        
        Button(action: {
            self.vm.chart = self.showChart
        }) {
            VStack (alignment: .center, spacing: 0) {
                MenuIconView(name: image)
                Text(title)
                .font(.system(size: 10, weight: .bold, design: .default))
                .foregroundColor(Colors.mainColor)
                .offset(x: 0, y: -8)
            }
            .frame(width: 120)
        }
    }
    
}
