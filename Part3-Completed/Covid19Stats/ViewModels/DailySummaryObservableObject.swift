//
//  DailySummaryObservableObject.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

class DailySummaryObservableObject: NSObject, ObservableObject {
    
    @Published var stats: DailySummaryCaseStats?
    @Published var isLoading = false
    @Published var error: Error?
    
    let service: Covid19RepositoryService
    
    init(service: Covid19RepositoryService = Covid19APIService.shared) {
        self.service = service
    }
    
    func fetchSummary() {
        isLoading = true
        error = nil
        
        service.getDailySummaryStats { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let stats):
                self.stats = stats
            case .failure(let error):
                self.error = error
            }
        }
    }
}
