//
//  Model.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 01/08/20.
//

import Foundation

struct DailySummaryCaseStas: Decodable {
    let global: CaseStats
    let countries: [CaseStats]
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
}

struct CaseStats: Decodable {
    let id: String?
    let name: String?
    let iso: String?
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    let date: Date?
    
    enum CodingKeys: String, CodingKey {
        case id = "Slug"
        case name = "Country"
        case iso = "ISO2"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case date = "Date"
    }
}

struct CountryTotalCase: Decodable {
    let country: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}

struct Country: Decodable {
    let id: String
    let name: String
    let iso: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Slug"
        case name = "Country"
        case iso = "ISO2"
    }
}

struct TotalCaseCount {
    let title: String
    let confirmed: Int
    let death: Int
    let recovered: Int
    
    var confirmedText: String {
        Utils.numberFormatter.string(from: NSNumber(value: confirmed)) ?? "0"
    }
    
    var deathText: String {
        Utils.numberFormatter.string(from: NSNumber(value: death)) ?? "0"
    }
    
    var recoveredText: String {
        Utils.numberFormatter.string(from: NSNumber(value: recovered)) ?? "0"
    }
    
    var sick: Int {
        confirmed - death - recovered
    }
    
    var recoveryRate: Double {
        (Double(recovered) / Double(confirmed)) * 100
    }
    
    var fatalityRate: Double {
        (Double(death) / Double(confirmed)) * 100
    }
    
    var sickText: String {
        Utils.numberFormatter.string(from: NSNumber(value: sick)) ?? "0"
    }
    
    var recoveryRateText: String {
        (Utils.numberFormatter.string(from: NSNumber(value: recoveryRate)) ?? "0") + "%"
    }
    
    var fataliityRateText: String {
        (Utils.numberFormatter.string(from: NSNumber(value: fatalityRate)) ?? "0") + "%"
    }
}

