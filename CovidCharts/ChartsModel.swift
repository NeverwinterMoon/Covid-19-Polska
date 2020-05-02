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



////////


struct GlobalDatum: Codable {
    let infected: Int?
    let tested: DeceasedUnion
    let recovered: Recovered
    let deceased: DeceasedUnion
    let country: String
//    let moreData, historyData: String
  //  let sourceURL: String?
    let lastUpdatedSource: String?
    let lastUpdatedApify: String

    enum CodingKeys: String, CodingKey {
        case infected, tested, recovered, deceased, country //, historyData  moreData,
  //      case sourceURL = "sourceUrl"
        case lastUpdatedSource, lastUpdatedApify
    }
}

enum DeceasedUnion: Codable {
    case enumeration(DeceasedEnum)
    case integer(Int)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(DeceasedEnum.self) {
            self = .enumeration(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(DeceasedUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DeceasedUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum DeceasedEnum: String, Codable {
    case na = "NA"
}

enum Recovered: Codable {
    case enumeration(DeceasedEnum)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(DeceasedEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(Recovered.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Recovered"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

typealias GlobalData = [GlobalDatum]
