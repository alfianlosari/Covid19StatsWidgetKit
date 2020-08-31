//
//  StatsWidgetEntryView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 24/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import WidgetKit

struct StatsWidgetEntryView : View {
    
    var entry: TotalCaseEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            StatsWidgetSmall(entry: entry)
        case .systemLarge:
            StatsWidgetLarge(entry: entry)
        default:
            StatsWidgetMedium(entry: entry)
        }
    }
}

struct StatsWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatsWidgetEntryView(entry: TotalCaseEntry.stub)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .environment(\.colorScheme, .dark)
        }
    }
}
