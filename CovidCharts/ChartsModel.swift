//
//  ChartsModel.swift
//  CovidCharts
//
//  Created by Timothy Stokarski on 16/04/2020.
//  Copyright © 2020 Timothy Stokarski. All rights reserved.
//

import Foundation

// MARK: - Alltime day data
struct Day: Decodable, Hashable {
    let confirmed, deaths, recovered: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case date = "Date"
    }
}

struct DailyData: Hashable {
    var confirmed: Int
    var deaths: Int
    var recovered: Int
    var confirmedInc: Int
    var deathsInc: Int
    var recoveredInc: Int
    var date: String
}

enum CountryCode: String, Decodable {
    case pl = "PL"
}

typealias Days = [Day]

// MARK: - PolandLatest
struct PolandLatest: Codable {
    let infected, deceased: Int
    let infectedByRegion: [InfectedByRegion]
    let sourceURL: String
    let lastUpdatedAtApify: String
    let readMe: String

    enum CodingKeys: String, CodingKey {
        case infected, deceased, infectedByRegion
        case sourceURL = "sourceUrl"
        case lastUpdatedAtApify, readMe
    }
}

// MARK: - InfectedByRegion
struct InfectedByRegion: Codable {
    let region: String
    let infectedCount, deceasedCount: Int
}
