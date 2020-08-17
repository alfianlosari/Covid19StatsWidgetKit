//
//  CaseStatGrid.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 03/08/20.
//

import SwiftUI
import WidgetKit

struct CaseStatGrid: View {
    
    let totalCount: TotalCaseCount
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                LazyVGrid(columns: columns, spacing: 0) {
                    CaseStatView(text: "Confirmed", totalCountText: totalCount.confirmedText, color: confirmedColor, height: proxy.size.height / 2)
                    CaseStatView(text: "Deaths", totalCountText: totalCount.deathText, color: deathColor, height: proxy.size.height / 2)
                    CaseStatView(text: "Sick", totalCountText: totalCount.sickText, color: sickColor, height: proxy.size.height / 2)
                    CaseStatView(text: "Recovered", totalCountText: totalCount.recoveredText, color: recoveredColor, height: proxy.size.height / 2)
                }
            }
        }
    }
}

struct CaseStatGrid_Previews: PreviewProvider {
    static var previews: some View {
        CaseStatGrid(totalCount: .init(title: "USA", confirmed: 300, death: 100, recovered: 100))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
