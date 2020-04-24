//
//  HomeChartDetailsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 24/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct HomeChartDetailsView: View {
    var body: some View {
                        VStack (alignment: .leading, spacing: 4) {
                        DetailsSectionTitle(title: "Date", textColor: Colors.main)
                            DetailsText(parameter: "Zakażenia", currentValue: 0)
                            DetailsText(parameter: "Zgony", currentValue: 0)
                            Spacer()
                            .frame(height: 4)
                            DetailsSectionTitle(title: "Łącznie", textColor: Colors.main)
                            DetailsText(parameter: "Zakażenia", currentValue: 0)
                            DetailsText(parameter: "Zgony", currentValue: 0)
                        }
 
    }
}

struct HomeChartDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartDetailsView()
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
    }
}

fileprivate struct DetailsText: View {
    
    var parameter: String
    var currentValue: Int
    
    var body: some View {
        HStack {
            Text("\(parameter): ")
                .foregroundColor(Colors.label).foregroundColor(Colors.label)
                .font(Fonts.text)
            Spacer()
            Text("\(Int(currentValue))")
                .foregroundColor(Colors.label)
                .font(Fonts.indicatorTextBolded)
        }
        .padding(.horizontal)
    }
}
