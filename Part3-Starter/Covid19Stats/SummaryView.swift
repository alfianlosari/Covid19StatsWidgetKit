//
//  SummaryView.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

struct SummaryView: View {
    
    @EnvironmentObject var watchlist: WatchlistObservableObject
    @EnvironmentObject var dailySummary: DailySummaryObservableObject
    
    var body: some View {
        NavigationView {
            ZStack {
                if let stats = dailySummary.stats {
                    List {
                        Section(header: Text("Global Lifetime Stats")) {
                            Text(stats.date, style: .date)
                                .font(.headline)
                            CasePieRow(totalCount: stats.global.totalCaseCount, date: Date())
                            CaseStatGrid(totalCount: stats.global.totalCaseCount)
                                .frame(height: 140)
                                .cornerRadius(8)
                                .padding(.vertical)
                        }
                        
                        Section(header: Text("Countries Daily Stats")) {
                            ForEach(stats.countries) { countryStat in
                                NavigationLink(
                                    destination: CountryDetailView(country: countryStat.country),
                                    label: {
                                        CountryStatsRowView(countryStat: countryStat, isAddedToWatchlist: watchlist.isAddedToWatchlist(country: countryStat.country))
                                            .padding(.vertical)
                                        
                                    })
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                } else {
                    ProgressView()
                }
                
            }
            .navigationTitle("Daily Summary")
            
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
