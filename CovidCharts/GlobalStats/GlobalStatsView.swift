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
                        GlobalDetailsString(title: "Ostatnia aktualizacja", value: self.vm.data.date?.formattedDate(.long))
                        GlobalDetailsInt(title: "Zakażenia łącznie", number: self.vm.data.global?.totalConfirmed)
                        GlobalDetailsInt(title: "Zakażenia dziś", number: self.vm.data.global?.newConfirmed)
                        GlobalDetailsInt(title: "Zgony łącznie", number: self.vm.data.global?.totalDeaths)
                        GlobalDetailsInt(title: "Zgony dziś", number: self.vm.data.global?.newDeaths)
                        GlobalDetailsInt(title: "Wyzdrowienia łącznie", number: self.vm.data.global?.totalRecovered)
                        GlobalDetailsInt(title: "Wyzdrowienia dziś", number: self.vm.data.global?.newRecovered)
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
                            .background(Color.orange)
                        Spacer()
                    }
                    
                    VStack (spacing: 16) {
                        GlobalDetailsString(title: "Kraj", value: "Zakażenia łącznie")
                        ForEach(self.vm.topCountries, id: \.self) { (country) in
                            
                            Button(action: {
                                self.tappedCountry = country
                                self.showCountryDetails.toggle()
                            }) {
                                GlobalDetailsInt(title: country.country ?? "", number: country.totalConfirmed ?? 0)
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

struct GlobalDetailsInt: View {
    
    var title: String
    var number: Int?
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(Colors.label)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 200, alignment: .center)
                Text(String(number ?? 0))
                    .foregroundColor(Colors.chartTop)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 120, alignment: .center)
            }

        }
    }
}

struct GlobalDetailsString: View {
    
    var title: String
    var value: String?

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(Colors.label)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 200, alignment: .center)
                Text(value ?? "")
                    .foregroundColor(Colors.chartTop)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 120, alignment: .center)
            }

        }
    }
}

struct CountriesBarChart: View {
    
    @ObservedObject var vm: GlobalStatsViewModel
    
    func setHeight(_ value: Double) -> CGFloat {
        let heightMultiplier = CGFloat(value/self.vm.maxConfirmed)
        return CGFloat((UIScreen.height/4)) * heightMultiplier
    }
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (alignment: .bottom, spacing: 16) {
                ForEach(vm.topCountries, id: \.self) { (country) in
                    VStack (alignment: .center, spacing: 4) {
                        HStack (alignment: .bottom) {
                            VStack {
                                DetailsText(text: "\(country.totalConfirmed ?? 0)", color: Colors.label)
                                Spacer()
                                    .frame(width: UIScreen.width/7, height: self.setHeight(Double(country.totalConfirmed ?? 0)), alignment: .center)
                                    .background(RoundedCorners(color: Colors.chartTop, tl: 8, tr: 8, bl: 0, br: 0))
                                    .shadow(color: Colors.chartTop.opacity(0.3), radius: 5, x: 4, y: -2)
                            }
                            VStack {
                                DetailsText(text: "\(country.totalDeaths ?? 0)", color: Colors.label)
                                Spacer()
                                    .frame(width: UIScreen.width/7, height: self.setHeight(Double(country.totalDeaths ?? 0)), alignment: .center)
                                    .background(RoundedCorners(color: Colors.chartBot, tl: 8, tr: 8, bl: 0, br: 0))
                                    .shadow(color: Colors.chartBot.opacity(0.3), radius: 5, x: 4, y: -2)
                            }
                        }
                        //    .padding(.top, 8)
                        Text(country.country ?? "")
                            .font(.system(size: 8, weight: .semibold, design: .rounded))
                            .foregroundColor(Colors.label)
                            .frame(height: 20, alignment: .center)
                    }
                    .background(Color.red)
                }
            }
        }.padding(.leading, 16)
    }
}
