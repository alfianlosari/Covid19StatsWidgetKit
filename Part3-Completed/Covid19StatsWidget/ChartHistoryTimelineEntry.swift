//
//  ChartHistoryTimelineEntry.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 23/08/20.
//

import WidgetKit

struct WatchlistStatsTimelineEntry: TimelineEntry {
    public let date: Date
    public let countryCases: [(country: Country, totalCase: CaseStats?)]
    
}

extension WatchlistStatsTimelineEntry {

    static var stub: WatchlistStatsTimelineEntry {
        .init(date: Date(), countryCases: [
            
            (Country(id: "japan", name: "Japan", iso: "JP"), CaseStats(id: nil, name: nil, iso: nil, countryCode: nil, newConfirmed: 100, totalConfirmed: 100, newDeaths: 100, totalDeaths: 100, newRecovered: 100, totalRecovered: 100, date: Date())),
            (Country(id: "oman", name: "Oman", iso: "OM"), CaseStats(id: nil, name: nil, iso: nil, countryCode: nil, newConfirmed: 100, totalConfirmed: 100, newDeaths: 100, totalDeaths: 100, newRecovered: 100, totalRecovered: 100, date: Date())),
            (Country(id: "singapore", name: "Singapore", iso: "SG"), CaseStats(id: nil, name: nil, iso: nil, countryCode: nil, newConfirmed: 100, totalConfirmed: 100, newDeaths: 100, totalDeaths: 100, newRecovered: 100, totalRecovered: 100, date: Date())),
            (Country(id: "israel", name: "Israel", iso: "IL"), CaseStats(id: nil, name: nil, iso: nil, countryCode: nil, newConfirmed: 100, totalConfirmed: 100, newDeaths: 100, totalDeaths: 100, newRecovered: 100, totalRecovered: 100, date: Date()))
        ])
    }
    
//    static var placeholder: TotalCaseEntry {
//        TotalCaseEntry(date: Date(), totalCount: .init(title: "----", confirmed: 1000, death: 1000, recovered: 1000), isPlaceholder: true)
//
//    }
}
