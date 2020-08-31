//
//  ChartHistoryTimelineEntry.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 23/08/20.
//

import WidgetKit

struct WatchlistStatsTimelineEntry: TimelineEntry {
    public let date: Date
    public let countryCases: [(country: Country, caseStats: CaseStats?)]
    public var isPlaceholder = false
}

extension WatchlistStatsTimelineEntry {

    static var stub: WatchlistStatsTimelineEntry {
        .init(date: Date(), countryCases: [
            (Country(id: "japan", name: "Japan", iso: "JP"), .stub),
            (Country(id: "oman", name: "Oman", iso: "OM"), .stub),
            (Country(id: "singapore", name: "Singapore", iso: "SG"), .stub),
            (Country(id: "indonesia", name: "Indonesia", iso: "ID"), .stub)
        ])
    }
    
    static var placeholder: WatchlistStatsTimelineEntry {
        var stub = WatchlistStatsTimelineEntry.stub
        stub.isPlaceholder = true
        return stub
    }
}
