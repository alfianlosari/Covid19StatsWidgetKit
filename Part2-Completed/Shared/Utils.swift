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
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator  = true
        return formatter
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
