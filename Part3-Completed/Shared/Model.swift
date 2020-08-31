//
//  Model.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 01/08/20.
//

import Foundation

struct DailySummaryCaseStats: Decodable {
    let global: CaseStats
    let countries: [CaseStats]
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
        case date = "Date"
    }
    

}

struct CaseStats: Decodable, Identifiable {
    let id: String?
    let name: String?
    let iso: String?
    let countryCode: String?
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
        case countryCode = "CountryCode"
    }
    
    var country: Country {
        return Country(id: id ?? "", name: name ?? "", iso: iso ?? countryCode ?? "")
    }
    
    var totalCaseCount: TotalCaseCount {
        .init(title: displayName, confirmed: totalConfirmed, death: totalDeaths, recovered: totalRecovered)
    }
    
    var newTotalCaseCount: TotalCaseCount {
        .init(title: displayName, confirmed: newConfirmed, death: newDeaths, recovered: newRecovered)
    }
    
    var displayName: String {
        if let flag = iso?.flag, let name = name {
            return "\(flag) \(name)"
        } else if let flag = countryCode?.flag, let name = name {
            return "\(flag) \(name)"
        }  else if let name = name {
            return name
        } else {
            return "🌏"
        }
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
    
    var totalCaseCount: TotalCaseCount {
        .init(title: country, confirmed: confirmed, death: deaths, recovered: recovered)
        
    }
    
    
}

struct Country: Codable, Identifiable, Hashable  {
    let id: String
    let name: String
    let iso: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Slug"
        case name = "Country"
        case iso = "ISO2"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(iso)
    }
    
    var displayName: String {
        "\(iso.flag) \(name)"
    }
    
    var url: URL {
        let string = "stats://watchlist?id=\(id)&name=\(name)&iso=\(iso)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: string)!
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


extension CaseStats {
    
    static var stub: CaseStats {
        .init(id: "indonesia", name: "Indonesia", iso: "ID", countryCode: nil, newConfirmed: 100, totalConfirmed: 100, newDeaths: 100, totalDeaths: 100, newRecovered: 100, totalRecovered: 100, date: Date())
    }
    
}
