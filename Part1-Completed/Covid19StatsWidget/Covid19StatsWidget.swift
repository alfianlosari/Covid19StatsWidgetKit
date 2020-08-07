//
//  Covid19StatsWidget.swift
//  Covid19StatsWidget
//
//  Created by Alfian Losari on 01/08/20.
//

import WidgetKit
import SwiftUI

@main
struct Covid19StatsWidget: Widget {
    private let kind: String = "Covid19StatsWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GlobalTotalStatsTimelineProvider(), content: { entry in
            StatsWidgetEntryView(entry: entry)
        })
        .configurationDisplayName("Covid19-Stats")
        .description("Show latest global lifetime total stats")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Covid19StatsWidget_Previews: PreviewProvider {
    static var previews: some View {
        StatsWidgetEntryView(entry: TotalCaseEntry.stub)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
