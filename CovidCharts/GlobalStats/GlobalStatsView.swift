//
//  GlobalStatsView.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 02/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI

struct GlobalStatsView: View {
    
    @ObservedObject var vm: GlobalStatsViewModel
    @Binding var showView: Bool
    @State var showCountryDetails: Bool = false
    @State var showInfo: Bool = false
    @State var tappedCountry = Country(country: nil, countryCode: nil, slug: nil, newConfirmed: nil, totalConfirmed: nil, newDeaths: nil, totalDeaths: nil, newRecovered: nil, totalRecovered: nil, date: nil)
    
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = 0
    
    var body: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            VStack {
                GlobalStatsTitleBar(title: "Świat", showView: $showView, showInfo: $showInfo)
                ScrollView (.vertical, showsIndicators: false) {
                    SectionTitle(title: "Statystyki ogólne", icon: Icons.table)
                    VStack (spacing: 16) {
                        DetailsLine(title: "Ostatnia aktualizacja", value: self.vm.data.date?.formattedDate(.long) ?? "")
                        DetailsLine(title: "Zakażenia łącznie", number: self.vm.data.global?.totalConfirmed)
                        DetailsLine(title: "Zakażenia dziś", number: self.vm.data.global?.newConfirmed)
                        DetailsLine(title: "Zgony łącznie", number: self.vm.data.global?.totalDeaths)
                        DetailsLine(title: "Zgony dziś", number: self.vm.data.global?.newDeaths)
                        DetailsLine(title: "Wyzdrowienia łącznie", number: self.vm.data.global?.totalRecovered)
                        DetailsLine(title: "Wyzdrowienia dziś", number: self.vm.data.global?.newRecovered)
                    }
                    SectionTitle(title: "Statystyki krajowe", icon: Icons.flag)
                    
                    HStack {
                        Spacer()
                        Text("Lista zawiera kraje w których odnotowano ponad 1000 przypadków koronawirusa.\nNaciśnij na wybrany kraj, aby wyświetlić szczegółowe statystyki.")
                            .padding(.bottom, 16)
                            .foregroundColor(Colors.label)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.leading)
                            .frame(width: 328)
                        Spacer()
                    }
                    
                    VStack (spacing: 16) {
                        DetailsLine(title: "Kraj", value: "Zakażenia")
                        ForEach(self.vm.topCountries, id: \.self) { (country) in
                            CountryLine(title: country.country, value: country.totalConfirmed) {
                                self.tappedCountry = country
                                self.showCountryDetails.toggle()
                            }
                        }
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            .blur(radius: self.showInfo ? 10 : 0)
            .blur(radius: self.showCountryDetails ? 10 : 0)
            InfoPopupView(showView: $showInfo, title: "Źródło danych", message: "Dane na podstawie:\ncovid19api.com/\napify.com/covid-19")
                .scaleEffect(self.showInfo ? 1.0 : 0.5)
                .opacity(self.showInfo ? 1.0 : 0.0)
                .animation(.spring())
            CountryDetailsView(showCountryDetails: $showCountryDetails, country: tappedCountry)
                .scaleEffect(self.showCountryDetails ? 1.0 : 0.5)
                .opacity(self.showCountryDetails ? 1.0 : 0.0)
                .animation(.spring())
        }
    }
}

struct GlobalStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsView(vm: GlobalStatsViewModel(data: GlobalData(global: nil, countries: nil, date: nil)), showView: .constant(true))
    }
}

struct GlobalStatsTitleBar: View {
    
    var title: String
    @Binding var showView: Bool
    @Binding var showInfo: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                self.showView.toggle()
            }) {
                IconView(name: Icons.hide, size: .medium, weight: .regular, color: Colors.chartTop)
            }
            .frame(width: 50, height: 40)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 0, tr: 16, bl: 0, br: 16))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
            Text(title)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .foregroundColor(Colors.label)
                .padding(.leading, 8)
            Spacer()
            Button(action: {
                self.showInfo.toggle()
            }) {
                IconView(name: Icons.info, size: .medium, weight: .regular, color: Colors.chartTop)
            }
            .frame(width: 50, height: 40)
            .background(RoundedCorners(color: Colors.customViewBackground, tl: 16, tr: 0, bl: 16, br: 0))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
        }
        .padding(.top, 16)
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
                    .animation(nil)
                    .frame(width: 160, alignment: .center)
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

fileprivate struct CountryLine: View {
    
    var title: String?
    var value: Int?
    var action: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        self.action()
                    }) {
                        Text(title ?? "")
                            .foregroundColor(Colors.label)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .animation(nil)
                    }
                }
                .frame(width: 160, alignment: .center)
                Text(String(value ?? 0))
                    .foregroundColor(Colors.chartTop)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 100, alignment: .center)
                    .animation(nil)
            }

        }
    }
}
