//
//  GlobalStatsViewModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 03/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import SwiftUI
import Combine

class GlobalStatsViewModel: ObservableObject {
    
    enum Ratio {
        case deaths
        case recovered
    }
    
    let emptyCountryData = Country(country: "", countryCode: "", slug: "", newConfirmed: 0, totalConfirmed: 0, newDeaths: 0, totalDeaths: 0, newRecovered: 0, totalRecovered: 0, date: "")
    
    @Published var data: GlobalData
    
    init(data: GlobalData) {
        self.data = data
    }
    
    var topCountries: [Country] {
        var countries = [Country]()
        self.data.countries?.forEach({ (country) in
            if country.totalConfirmed ?? 0 > 1000 {
                countries.append(country)
            }
        })
        countries.sort { (country2, country1) -> Bool in
            country2.totalConfirmed ?? 0 > country1.totalConfirmed ?? 0
        }
        return countries
    }
    
    var maxConfirmed: Double {
        let value = data.countries?.max(by: { (country1, country2) -> Bool in
            return country2.totalConfirmed ?? 0 > country1.totalConfirmed ?? 0
            })?.totalConfirmed ?? 0
        return Double(value)
    }
    
    func getCountryWithMax(_ parameter: ParameterType) -> Country {
        guard let countries = data.countries else {
            return emptyCountryData
        }
        switch parameter {
        case .confirmed: return countries.max(by: { $1.totalConfirmed ?? 0 > $0.totalConfirmed ?? 0 }) ?? emptyCountryData
        case .confirmedInc: return countries.max(by: { $1.newConfirmed ?? 0 > $0.newConfirmed ?? 0 }) ?? emptyCountryData
        case .deaths: return countries.max(by: { $1.totalDeaths ?? 0 > $0.totalDeaths ?? 0 }) ?? emptyCountryData
        case .deathsInc: return countries.max(by: { $1.newDeaths ?? 0 > $0.newDeaths ?? 0 }) ?? emptyCountryData
        case .recovered: return countries.max(by: { $1.totalRecovered ?? 0 > $0.totalRecovered ?? 0 }) ?? emptyCountryData
        case .recoveredInc: return countries.max(by: { $1.newRecovered ?? 0 > $0.newRecovered ?? 0 }) ?? emptyCountryData
        default: return emptyCountryData
        }
    }
    
    func getRatio(_ country: Country, _ ratio: Ratio) -> CGFloat {
        switch ratio {
        case .deaths: return CGFloat(Double((country.totalDeaths ?? 0)) / Double((country.totalConfirmed ?? 0)))
        case .recovered: return CGFloat(Double((country.totalRecovered ?? 0)) / Double((country.totalConfirmed ?? 0)))
        }
    }
    
}
