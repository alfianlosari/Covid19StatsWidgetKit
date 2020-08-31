//
//  CountryStatsRowView.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

struct CountryStatsRowView: View {
    
    @EnvironmentObject var watchlist: WatchlistObservableObject
    
    let countryStat: CaseStats
    let isAddedToWatchlist: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(countryStat.displayName)
                    .font(.headline)
                Spacer()
                Image(systemName: isAddedToWatchlist ? "star.fill" : "star")
                    .foregroundColor(Color(UIColor.systemBlue))
                    .onTapGesture {
                        watchlist.toggle(country: countryStat.country)
                    }
            }
            
            HStack {
                Text(countryStat.date ?? Date(), style: .date)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Lifetime")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.caption)
            
            
            HStack(spacing: 8) {
                VStack(spacing: 0) {
                    CaseStatView(text: "Confirmed", totalCountText: countryStat.newTotalCaseCount.confirmedText, color: confirmedColor)
                    CaseStatView(text: "Deaths", totalCountText: countryStat.newTotalCaseCount.deathText, color: deathColor)
                    CaseStatView(text: "Recovered", totalCountText: countryStat.newTotalCaseCount.recoveredText, color: recoveredColor)
                }
                .frame(height: 128)
                .cornerRadius(8)
                
                VStack {
                    VStack(spacing: 0) {
                        CaseStatView(text: "Confirmed", totalCountText: countryStat.totalCaseCount.confirmedText, color: confirmedColor)
                        CaseStatView(text: "Deaths", totalCountText: countryStat.totalCaseCount.deathText, color: deathColor)
                        CaseStatView(text: "Recovered", totalCountText: countryStat.totalCaseCount.recoveredText, color: recoveredColor)
                    }
                    .frame(height: 128)
                    .cornerRadius(8)
                }
            }
        }
        
    }
}

struct CountryStatsRowView_Previews: PreviewProvider {
    static var previews: some View {
        CountryStatsRowView(countryStat: CaseStats.init(id: "test", name: nil, iso: nil, countryCode: nil, newConfirmed: 100, totalConfirmed: 100, newDeaths: 100, totalDeaths: 100, newRecovered: 100, totalRecovered: 100, date: Date()), isAddedToWatchlist: false)
    }
}
