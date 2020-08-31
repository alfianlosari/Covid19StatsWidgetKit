//
//  Covid19StatsWidget.swift
//  Covid19StatsWidget
//
//  Created by Alfian Losari on 01/08/20.
//

import WidgetKit
import SwiftUI

struct Covid19StatsWidget: Widget {
    private let kind: String = "Covid19StatsWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectCountryIntent.self, provider: TotalStatsIntentTimelineProvider(), content: { (entry) in
            StatsWidgetEntryView(entry: entry)
                .widgetURL(entry.url)
        })
        .configurationDisplayName("Covid19-Stats")
        .description("Show latest lifetime total stats")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Covid19StatsWidget_Previews: PreviewProvider {
    static var previews: some View {
        StatsWidgetEntryView(entry: TotalCaseEntry.stub)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


struct WatchlistStatsWidget: Widget {
    
    private let kind: String = "WatchlistStatsWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WatchlistStatsTimelineProvider(), content: { (entry)  in
            WatchlistStatsWidgetEntryView(entry: entry)
        })
        .configurationDisplayName("Covid19-Stats Watchlist")
        .description("Show watchlist countries daily and lifetime stats")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}


@main
struct Covid19StatsBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        Covid19StatsWidget()
        WatchlistStatsWidget()
    }
}
