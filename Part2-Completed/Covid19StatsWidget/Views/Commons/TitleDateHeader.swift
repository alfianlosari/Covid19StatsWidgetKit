//
//  TitleDateHeader.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 03/08/20.
//

import SwiftUI
import WidgetKit

struct TitleDateHeader: View {
    
    let title: String
    let date: Date
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            Text(date, style: .time)
                .font(.system(size: 12, weight: .semibold))
        }
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
}

struct TitleDateHeader_Previews: PreviewProvider {
    static var previews: some View {
        TitleDateHeader(title: "USA", date: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
