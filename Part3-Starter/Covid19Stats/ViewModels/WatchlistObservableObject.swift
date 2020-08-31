//
//  WatchlistObservableObject.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

class WatchlistObservableObject: NSObject, ObservableObject {
    
    private let userDefaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
        
    @Published private(set) var watchlist: [Country] = [] {
        didSet {
            save(countries: watchlist)
        }
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        if let watchlist = userDefaults.object(forKey: "watchlist") as? Data,
           let countries = try? decoder.decode([Country].self, from: watchlist) {
            self.watchlist = countries
        }
    }
    
    func isAddedToWatchlist(country: Country) -> Bool {
        isExists(country: country)
    }
    
    func toggle(country: Country) {
        if isExists(country: country) {
            remove(country)
        } else {
            add(country)
        }
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        var countries = self.watchlist
        countries.move(fromOffsets: indices, toOffset: newOffset)
        self.watchlist = countries
    }
    
    private func add(_ country: Country) {
        var countries = self.watchlist
        countries.insert(country, at: 0)
        self.watchlist = countries
    }
    
    private func remove(_ country: Country) {
        var countries = self.watchlist
        guard let index = countries.firstIndex(where: { $0.id == country.id }) else {
            return
        }
        countries.remove(at: index)
        self.watchlist = countries
    }
    
    private func save(countries: [Country]) {
        if let encoded = try? encoder.encode(countries) {
            userDefaults.set(encoded, forKey: "watchlist")
        }
    }
    
    private func isExists(country: Country) -> Bool {
        (watchlist ).first { country.id == $0.id } != nil
    }
}
