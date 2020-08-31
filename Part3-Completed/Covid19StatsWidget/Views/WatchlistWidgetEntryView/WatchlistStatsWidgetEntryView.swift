//
//  ChartHistoryWidgetEntryView.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 23/08/20.
//

import SwiftUI
import WidgetKit

struct WatchlistStatsWidgetEntryView: View {
    
    var entry: WatchlistStatsTimelineEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        ZStack {
            if entry.countryCases.isEmpty {
                Link(destination: URL(string: "stats://search")!, label: {
                    Text("Add countries to watchlist from the App")
                        .foregroundColor(Color(UIColor.systemBlue))
                        .padding()
                })
            } else {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Text("Watchlist")
                        Spacer()
                        Text(entry.date, style: .date)
                        Text(entry.date, style: .time)
                        Spacer()
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    ForEach(entry.countryCases.prefix( family == .systemMedium ? 2 : 4), id: \.country) { countryCase in
                        Link(destination: countryCase.country.url, label: {
                            if let caseStats = countryCase.caseStats {
                                WatchlistWidgetRowView(country: countryCase.country, caseStats: caseStats)
                            } else {
                                Text(countryCase.country.displayName)
                            }
                        })
                                              
                    }
                }
            }
        }.redacted(reason: entry.isPlaceholder ? .placeholder : .init())
    }
}

struct WatchlistStatsWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WatchlistStatsWidgetEntryView(entry: .stub)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            WatchlistStatsWidgetEntryView(entry: .stub)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

