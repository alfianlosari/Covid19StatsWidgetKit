//
//  TotalCountriesObservableObject.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

class TotalCountriesObservableObject: NSObject, ObservableObject {
    
    @Published var countries: [Country]?
    @Published var isLoading = false
    @Published var error: Error?
    
    let service: Covid19RepositoryService
    
    init(service: Covid19RepositoryService = Covid19APIService.shared) {
        self.service = service
    }
    
    func fetchTotalCountries() {
        self.isLoading = true
        self.error = nil
        
        service.getAllCountries { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let countries):
                self.countries = countries.sorted { $0.name < $1.name }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    
    
}
