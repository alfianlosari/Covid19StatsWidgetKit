//
//  ContentView.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 01/08/20.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @State var selection: String = "summary"
    
    var body: some View {
        TabView(selection: $selection) {
            SummaryView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("Summary")
                    }
                }
                .tag("summary")
            
            SearchCountriesView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag("search")
            
            WatchlistView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Watchlist")
                    }
                }
                .tag("watchlist")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
