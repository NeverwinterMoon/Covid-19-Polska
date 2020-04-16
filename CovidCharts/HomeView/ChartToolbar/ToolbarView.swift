//
//  MenuView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(vm: ChartViewModel())
    }
}

struct ToolbarView: View {
    
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        VStack {
            HStack (alignment: .center) {
                    MenuButton(title: "Zakażenia", image: Images.confirmed, showChart: .confirmed, vm: vm)
                    MenuButton(title: "Wyleczeni", image: Images.recovered, showChart: .recovered, vm: vm)
                    MenuButton(title: "Zgony", image: Images.deaths, showChart: .deaths, vm: vm)
                    MenuButton(title: "Info", image: Images.info, showChart: .confirmed, vm: vm)
            }
        }
        .frame(width: UIScreen.screenWidth, height: 65, alignment: .center)

    }
}

struct MenuIconView: View {
    var name: String
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .light))
            .imageScale(.large)
            .frame(width: 50, height: 50)
            .foregroundColor(Color(UIColor.label))
    }
}

struct MenuButton: View {
    
    var title: String
    var image: String
    var showChart: ChartType
    @ObservedObject var vm: ChartViewModel
    
    var body: some View {
        
        Button(action: {
            self.vm.setCustomData(self.showChart)
        }) {
            VStack (alignment: .center, spacing: 0) {
                MenuIconView(name: image)
                Text(title)
                .font(.system(size: 8, weight: .regular, design: .default))
                .foregroundColor(Color(UIColor.label))
                .offset(x: 0, y: -8)
            }
            .frame(width: 64, height: 64, alignment: .center)
            .background(Color(UIColor.systemBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 6)
        .padding(.horizontal, 8)
    }
    
}
