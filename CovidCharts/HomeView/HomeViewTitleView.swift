//
//  TitleView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 14/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    var title: String
    var lastUpdateTime: String
    var parameterSumValue: String
    var parameterIcon: String
    var parameterIncreaseValue: String
    var rightButtonIcon: String
    var rightButtonAction: () -> ()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            VerticalSpacer()
            HStack (alignment: .center) {
                VStack (alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(Fonts.title)
                        .foregroundColor(Colors.label)
                    HStack {
                        TitleIconView(name: Icons.time, size: .medium, weight: .regular, color: Colors.main)
                        Text(lastUpdateTime)
                            .font(Fonts.titleViewIcon)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Colors.main)
                        Spacer()
                    }
                    HStack {
                        HStack {
                            TitleIconView(name: parameterIcon, size: .medium, weight: .regular, color: Colors.main)
                            Text(parameterSumValue)
                                .font(Fonts.titleViewIcon)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Colors.main)
                            Spacer()
                        }
                        .frame(width: 80)
                        HStack {
                            TitleIconView(name: Icons.increase, size: .medium, weight: .regular, color: Colors.main)
                            Text(parameterIncreaseValue)
                                .font(Fonts.titleViewIcon)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Colors.main)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .padding(.leading, 24)
                .frame(width: 280, height: 90)
                .background(Colors.customViewBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                Spacer()
                IconView(name: rightButtonIcon, size: .large, weight: .bold, color: Colors.label)
                    .padding(.trailing)
                    .onTapGesture {
                        self.rightButtonAction()
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
        TitleView(title: "Covid-19 Polska", lastUpdateTime: "19 Marca 2020", parameterSumValue: "1231", parameterIcon: Icons.confirmed, parameterIncreaseValue: "123", rightButtonIcon: Icons.reload) {
            print("Right button tapped")
        }
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

struct VerticalSpacer: View {
    var body: some View {
        Spacer()
            .frame(width: UIScreen.width, height: 8, alignment: .center)
            .background(Color.clear)
    }
}
