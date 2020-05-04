//
//  CountryDetailsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 04/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct CountryDetailsView: View {
    
    @Binding var showCountryDetails: Bool
    var country: Country
    
    var body: some View {
        VStack (spacing: 16) {
            VStack (spacing: 16) {
                IconView(name: Icons.flag, size: .medium, weight: .semibold, color: Colors.customViewBackground)
                .frame(width: 60, height: 60, alignment: .center)
                .padding(.vertical, 8)
                .background(Colors.chartTop)
                .clipShape(Circle())
                .shadow(color: Colors.chartTop.opacity(0.7), radius: 8, x: -4, y: 8)
                .offset(x: 0, y: -38)
                VStack (spacing: 16) {
                    Text(country.country ?? "")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .animation(nil)
                    DetailsLine(title: "Zakażenia łącznie", number: country.totalConfirmed ?? 0)
                    DetailsLine(title: "Zakażenia dziś", number: country.newConfirmed ?? 0)
                    DetailsLine(title: "Zgony", number: country.totalDeaths ?? 0)
                    DetailsLine(title: "Zgony dziś", number: country.newDeaths ?? 0)
                    DetailsLine(title: "Wyzdrowienia", number: country.totalRecovered ?? 0)
                    DetailsLine(title: "Wyzdrowienia dziś", number: country.newRecovered ?? 0)
                    DetailsLine(title: "Przypadki śmiertelne\nwśród zakażonych (%)", value: ratioDeaths())
                    DetailsLine(title: "Przypadki wyzdrowień\nwśród zakażonych (%)", value: ratioRecovered())
                }
                .padding(.top, -40)
                .padding(.horizontal, 8)
                Button(action: {
                    self.showCountryDetails.toggle()
                }) {
                    Text("Zamknij")
                        .foregroundColor(Colors.chartBot)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.bottom, 16)
                }
            }
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 16, bl: 16, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            
        }
    }
    
    func ratioDeaths() -> String {
        return String(format: "%.2f", (Double(country.totalDeaths ?? 0)/Double(country.totalConfirmed ?? 0)*100)) + "%"
    }
    
    func ratioRecovered() -> String {
        return String(format: "%.2f", (Double(country.totalRecovered ?? 0)/Double(country.totalConfirmed ?? 0)*100)) + "%"
    }
    
}

struct CountryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailsView(showCountryDetails: .constant(true), country: Country(country: "Netherlands", countryCode: "NED", slug: "NED", newConfirmed: 12331, totalConfirmed: 1231231, newDeaths: 1233, totalDeaths: 12331, newRecovered: 123, totalRecovered: 12331, date: "2 May 2020"))
    }
}

fileprivate struct DetailsLine: View {
    
    var title: String
    var value: String
    
    init(title: String, value: String) {
        self.value = value
        self.title = title
    }
    
    init(title: String, number: Int?) {
        self.value = String(number ?? 0)
        self.title = title
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(Colors.label)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 160, alignment: .center)
                    .animation(nil)
                Text(value)
                    .foregroundColor(Colors.chartTop)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 100, alignment: .center)
                    .animation(nil)
            }

        }
    }
}
