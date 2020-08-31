//
//  Utils.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 02/08/20.
//

import Foundation

struct Utils {
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.usesGroupingSeparator  = true
        return formatter
    }()
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter
    }()
}

extension String {
    
    var flag: String {
        let base : UInt32 = 127397
        var s = ""
        for v in unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

extension CountryParam {
    
    convenience init(country: Country) {
        self.init(identifier: country.id, display: "\(country.iso.flag ) \(country.name)")
        self.iso = country.iso
    }
    
    static var global: CountryParam {
        CountryParam(country: .init(id: "global", name: "Global", iso: ""))
    }
}

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let urlDir = url(forResource: filename, withExtension: "json") else {
            return nil
        }
        
        let data = try Data(contentsOf: urlDir)
        let model = try Utils.jsonDecoder.decode(D.self, from: data)
        return model
    }
    
    
}

extension Array where Element == CountryTotalCase {
    
    var dailyCases: (confirmed: [(Date, Double)], deaths: [(Date, Double)], recovered: [(Date, Double)])? {
        guard !isEmpty else {
            return nil
        }
        var confirmed = [(Date, Double)]()
        var deaths = [(Date, Double)]()
        var recovered = [(Date, Double)]()
        
        let cases = Array(suffix(91))
        cases.enumerated().forEach { (index, element) in
            if index + 1 < cases.count {
                let nextStats = cases[index+1]
                confirmed.append((nextStats.date, Double(nextStats.confirmed - element.confirmed)))
                deaths.append((nextStats.date, Double(nextStats.deaths - element.deaths)))
                recovered.append((nextStats.date, Double(nextStats.recovered - element.recovered)))
            }
        }
        return (confirmed, deaths, recovered)
    }
}


extension UserDefaults {
    
    static var shared: UserDefaults {
        UserDefaults.init(suiteName: "group.alfianlosari.covid19stats") ?? .standard
    }
    
}
