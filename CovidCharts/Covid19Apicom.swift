//
//  Covid19Apicom.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 02/05/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import Foundation

struct Country: Codable, Hashable {
    let country: String?
    let countryCode: String?
    let slug: String?
    let newConfirmed: Int?
    let totalConfirmed: Int?
    let newDeaths: Int?
    let totalDeaths: Int?
    let newRecovered: Int?
    let totalRecovered: Int?
    let date: String?

    enum CodingKeys: String, CodingKey {

        case country = "Country"
        case countryCode = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case date = "Date"
    }

}

struct Global: Codable {
    let newConfirmed: Int?
    let totalConfirmed: Int?
    let newDeaths: Int?
    let totalDeaths: Int?
    let newRecovered: Int?
    let totalRecovered: Int?

    enum CodingKeys: String, CodingKey {

        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }

}

struct GlobalData: Codable {
    let global: Global?
    let countries: [Country]?
    let date: String?

    enum CodingKeys: String, CodingKey {

        case global = "Global"
        case countries = "Countries"
        case date = "Date"
    }
    
}
