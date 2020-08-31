//
//  ContentView.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 01/08/20.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @State var selectedCountry: Country?
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
        .sheet(item: $selectedCountry, onDismiss: {
            selectedCountry = nil
        }, content: { (country) in
            NavigationView {
                CountryDetailView(country: country)
            }
            
        })
        
        .onOpenURL(perform: { url in
            
            self.selection = url.host ?? "summary"
            guard let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems else {
                self.selectedCountry = nil
                return
            }
            
            var dict = [String: String]()
            queryItems.forEach { (item) in
                dict[item.name] = item.value
            }
            guard let id = dict["id"], let name = dict["name"], let iso = dict["iso"] else {
                self.selectedCountry = nil
                return
            }
            self.selectedCountry = Country(id: id, name: name, iso: iso)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
