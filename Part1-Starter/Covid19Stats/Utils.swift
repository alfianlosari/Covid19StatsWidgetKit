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
