//
//  ChartHistoryTimelineProvider.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 23/08/20.
//

import Foundation
import WidgetKit

struct WatchlistStatsTimelineProvider: TimelineProvider {
    
    typealias Entry = WatchlistStatsTimelineEntry
    let service = Covid19APIService.shared
    let decoder = Utils.jsonDecoder
    
    func placeholder(in context: Context) -> WatchlistStatsTimelineEntry {
        .placeholder
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WatchlistStatsTimelineEntry) -> Void) {
        guard !context.isPreview else {
            completion(.placeholder)
            return
        }
        
        guard let countries = loadCountriesFromUserDefaults(), !countries.isEmpty else {
            completion(.init(date: Date(), countryCases: []))
            return
        }
        getDailySummary(countries: countries, completion: completion)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WatchlistStatsTimelineEntry>) -> Void) {
        
        guard let countries = loadCountriesFromUserDefaults(), !countries.isEmpty else {
            let entry: WatchlistStatsTimelineEntry = .init(date: Date(), countryCases: [])
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
            return
        }
       
        getDailySummary(countries: countries) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 30)))
            completion(timeline)
        }
    }
    
    private func loadCountriesFromUserDefaults() -> [Country]? {
        let userDefaults = UserDefaults.shared
        if let watchlist = userDefaults.object(forKey: "watchlist") as? Data,
           let countries = try? decoder.decode([Country].self, from: watchlist) {
            return countries
        } else {
            return nil
        }
    }
    
    private func getDailySummary(countries: [Country], completion: @escaping (WatchlistStatsTimelineEntry) -> ()) {
        service.getDailySummaryStats { (result) in
            switch result {
            case .success(let stats):
                let countryCases = countries.map { (country) -> (Country, CaseStats?)  in
                    let caseStats = stats.countries.first(where: { (stats) -> Bool in
                        stats.id == country.id
                    })
                    return (country, caseStats)
                }
                
                completion(.init(date: Date(), countryCases: countryCases))
                
                
            case .failure(_):
                let countryCases = countries.map { (country) -> (Country, CaseStats?) in
                    (country, nil)
                }
                
                completion(.init(date: Date(), countryCases: countryCases))
            }
        }
    }
 
}
