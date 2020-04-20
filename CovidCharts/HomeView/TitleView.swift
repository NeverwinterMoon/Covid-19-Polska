//
//  TitleView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            VerticalSpacer()
            HStack (alignment: .center) {
                TitleLeftSide()
                Spacer()
                IconView(name: Images.reload, size: .large, weight: .bold, color: Colors.label)
                    .padding(.trailing)
                    .onTapGesture {
                  //      self.vm.loadData()
                }
                .frame(width: 90, height: 90, alignment: .center)
                .background(Colors.customViewBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                
            }
            .frame(width: UIScreen.width + 32, height: 90)
            VerticalSpacer()
        }
    }
    
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView().environmentObject(ChartViewModel())
    }
}

struct TitleIconView: View {
    var name: String
    var size: Image.Scale
    var weight: Font.Weight
    var color: Color
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 16, weight: weight))
            .imageScale(size)
            .frame(width: 24, height: 24)
            .foregroundColor(color)
    }
}

struct TitleInfoLineView: View {
    var icon: String
    var title: String
    var body: some View {
        HStack {
            TitleIconView(name: icon, size: .medium, weight: .regular, color: Colors.main)
            Text(title)
                .font(Fonts.titleViewIcon)
                .multilineTextAlignment(.leading)
                .foregroundColor(Colors.main)
            Spacer()
        }
    }
}

struct TitleLeftSide: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("Covid-19 Polska")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(Colors.label)
            TitleInfoLineView(icon: Images.time, title: vm.getLastUpdateDate())
            HStack {
                TitleInfoLineView(icon: Images.confirmed, title: "\(Int((vm.getDailyIncreaseData().last ?? 0)))")
                    .frame(width: 80)
                TitleInfoLineView(icon: Images.increase, title: "\(Int((vm.getDailyChangesData().last ?? 0)))")
                Spacer()
            }
        }
        .padding(.leading, 24)
        .frame(width: 280, height: 90)
        .background(Colors.customViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

struct VerticalSpacer: View {
    var body: some View {
        Spacer()
            .frame(width: UIScreen.width, height: 8, alignment: .center)
            .background(Color.clear)
    }
}
