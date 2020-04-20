//
//  MenuView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct ToolbarView: View {
    
    @EnvironmentObject var vm: ChartDatabase
    
    var body: some View {
        VStack {
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
            HStack (alignment: .center) {
                MenuButton(title: "Zakażenia", image: Images.confirmed, chart: .confirmed)
                MenuButton(title: "Wyleczeni", image: Images.recovered, chart: .recovered)
                MenuButton(title: "Zgony", image: Images.deaths, chart: .deaths)
                MenuButton(title: "Info", image: Images.info, chart: .confirmed)
            }
            .frame(width: UIScreen.width, height: 65, alignment: .center)
            Spacer()
                .frame(width: UIScreen.width, height: 8, alignment: .center)
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView().environmentObject(ChartDatabase())
    }
}

struct MenuIconView: View {
    var name: String
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .light))
            .imageScale(.large)
            .frame(width: 50, height: 50)
            .foregroundColor(Colors.label)
    }
}

struct MenuButton: View {
    
    var title: String
    var image: String
    var chart: ParameterType
    @EnvironmentObject var vm: ChartDatabase
    
    var body: some View {
        
        Button(action: {
            self.vm.setDataFromLast(30, chart: self.chart)
        }) {
            VStack (alignment: .center, spacing: 0) {
                MenuIconView(name: image)
                Text(title)
                .font(.system(size: 8, weight: .regular, design: .default))
                .foregroundColor(Colors.label)
                .offset(x: 0, y: -8)
            }
            .frame(width: 64, height: 64, alignment: .center)
            .background(Colors.customViewBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 6)
        .padding(.horizontal, 2)
    }
    
}
