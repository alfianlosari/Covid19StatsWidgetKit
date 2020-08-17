//
//  IntentHandler.swift
//  Covid19StatsIntentExtension
//
//  Created by Alfian Losari on 17/08/20.
//

import Intents

class IntentHandler: INExtension, SelectCountryIntentHandling {
    
    func provideCountryOptionsCollection(for intent: SelectCountryIntent, with completion: @escaping (INObjectCollection<CountryParam>?, Error?) -> Void) {
        Covid19APIService.shared.getAllCountries { (result) in
            switch result {
            case .success(let countries):
                let countryParams = countries.map { CountryParam(country: $0) }
                completion(
                    INObjectCollection(sections: [
                        INObjectSection(title: "Global", items: [CountryParam.global]),
                        INObjectSection(title: "Countries", items: countryParams)
                    ])
                , nil)
                
                
            case .failure(_):
                completion(
                    INObjectCollection(items: [CountryParam.global])
                , nil)
            }
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
