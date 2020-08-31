//
//  SearchCountriesView.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

struct SearchCountriesView: View {
    
    @StateObject var totalCountries = TotalCountriesObservableObject()
    @State var searchText: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                if let countries = totalCountries.countries {
                    VStack {
                        SearchBar(text: $searchText, placeholder: "Search")
                        List(countries.filter({ (country) -> Bool in
                            if searchText == "" {
                                return true
                            } else {
                                return country.name.lowercased().contains(searchText.lowercased())
                            }
                        })) { country in
                            NavigationLink(
                                destination: CountryDetailView(country: country),
                                label: {
                                    Text(country.displayName)
                                })
                            
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Search Country")
        }
        .onAppear {
            totalCountries.fetchTotalCountries()
        }


    }
}

struct SearchCountriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCountriesView()
    }
}
