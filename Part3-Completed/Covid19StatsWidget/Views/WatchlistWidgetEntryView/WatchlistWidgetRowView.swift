//
//  WatchlistWidgetRowView.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 23/08/20.
//

import SwiftUI
import WidgetKit

struct WatchlistWidgetRowView: View {
    
    let country: Country
    let caseStats: CaseStats
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(country.displayName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            VStack(spacing: 2) {
                WatchlistStatsNumberView(title: "Lifetime", totalCase: caseStats.totalCaseCount)
                WatchlistStatsNumberView(title: "Daily", totalCase: caseStats.newTotalCaseCount)
            }
        }
        .padding(.horizontal)
        .border(width: 0.3, edge: .bottom, color: Color(red: 224/255, green: 224/255, blue: 224/255))
    }
}

struct WatchlistStatsNumberView: View {
    
    var title: String
    var totalCase: TotalCaseCount
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 12))
                .frame(width: 46, alignment: .leading)
            Text(totalCase.confirmedText)
                .foregroundColor(confirmedColor)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text(totalCase.recoveredText)
                .foregroundColor(recoveredColor)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text(totalCase.deathText)
                .foregroundColor(deathColor)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.caption)
    }
}

struct WatchlistWidgetRowView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistWidgetRowView(country: CaseStats.stub.country, caseStats: .stub)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
    }
}
