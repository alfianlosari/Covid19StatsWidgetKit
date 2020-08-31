//
//  Covid19StatsApp.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 01/08/20.
//

import SwiftUI

@main
struct Covid19StatsApp: App {
    
    @StateObject var watchlist = WatchlistObservableObject()
    @StateObject var dailySummary = DailySummaryObservableObject()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(watchlist)
                .environmentObject(dailySummary)
                .onAppear {
                    dailySummary.fetchSummary()
                }
        }
    }
}
