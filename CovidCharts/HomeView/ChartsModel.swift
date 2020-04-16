//
//  ChartsModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import Foundation

// MARK: - Day
struct Day: Decodable, Hashable {
    let country: Country
    let countryCode: CountryCode
    let confirmed, deaths, recovered, active: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}

enum Country: String, Decodable {
    case poland = "Poland"
}

enum CountryCode: String, Decodable {
    case pl = "PL"
}

typealias Days = [Day]

struct TimeSeries: Decodable {
    let Poland: [Day]
}

struct DayData: Decodable, Hashable {
    let date: String
    let confirmed, deaths, recovered: Int
}
