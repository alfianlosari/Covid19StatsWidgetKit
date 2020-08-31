//
//  CountrySummaryObservableObject.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

class CountrySummaryObservableObject: NSObject, ObservableObject {
    
    @Published var totalCase: CountryTotalCase?
    @Published var cases: [CountryTotalCase]?
    @Published var isLoading = false
    @Published var error: Error?
    
    let service: Covid19RepositoryService
    
    init(service: Covid19RepositoryService = Covid19APIService.shared) {
        self.service = service
    }
    
    func fetchSummary(countryId: String) {
        isLoading = true
        error = nil
        
        service.getSummaries(countryId: countryId) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let summary):
                self.totalCase = summary.last
                self.cases = summary
                
            case .failure(let error):
                self.error = error
            }
        }
       
    }
}
