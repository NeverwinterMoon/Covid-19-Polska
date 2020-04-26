//
//  HomeChartDetailsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 24/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeChartDetailsView: View {
    
    @EnvironmentObject var vm: ChartViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack (alignment: .center, spacing: 8) {
                Text(vm.highlightedData.date.formattedDate(.long))
                    .font(Fonts.popupTitle)
                    .foregroundColor(Colors.label)
                    .animation(nil)
                    .padding(.top, 12)
                Spacer()
                    .frame(width: UIScreen.width - 32, height: 1, alignment: .center)
                    .background(Colors.label)
                HStack {
                    VStack (alignment: .leading, spacing: 4) {
                        DetailsSectionTitle(title: "Przyrost", textColor: Colors.main)
                        DetailsText(parameter: "Zakażenia", currentValue: vm.highlightedData.confirmedInc)
                        DetailsText(parameter: "Zgony", currentValue: vm.highlightedData.deathsInc)
                        DetailsText(parameter: "Wyzdrowienia", currentValue: vm.highlightedData.recoveredInc)
                    }
                    VStack (alignment: .leading, spacing: 4) {
                        DetailsSectionTitle(title: "Łącznie", textColor: Colors.main)
                        DetailsText(parameter: "Zakażenia", currentValue: vm.highlightedData.confirmed)
                        DetailsText(parameter: "Zgony", currentValue: vm.highlightedData.deaths)
                        DetailsText(parameter: "Wyzdrowienia", currentValue: vm.highlightedData.recovered)
                    }
                    
                }
                Spacer()
            }
         //   .padding(.all)
            .frame(width: UIScreen.width, height: UIScreen.height*0.23, alignment: .center)
            .background(RoundedCorners(color: Colors.appBackground, tl: 16, tr: 16, bl: 16, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeChartDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartDetailsView().environmentObject(ChartViewModel())
    }
}

fileprivate struct DetailsSectionTitle: View {
    
    var title: String
    var textColor: Color
    
    var body: some View {
        Text(title)
            .font(Fonts.popupTitle)
            .foregroundColor(textColor)
            .padding(.horizontal)
            .animation(nil)
    }
}

fileprivate struct DetailsText: View {
    
    var parameter: String
    var currentValue: Int
    
    var body: some View {
        HStack (spacing: 0) {
            Text("\(parameter): ")
                .foregroundColor(Colors.label).foregroundColor(Colors.label)
                .font(Fonts.textRounded)
                .animation(nil)
            Text("\(Int(currentValue))")
                .foregroundColor(Colors.label)
                .font(Fonts.textRounded)
                .animation(nil)
            Spacer()
        }
        .padding(.horizontal)
    }
}
