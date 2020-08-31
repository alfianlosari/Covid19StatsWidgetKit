//
//  MockAPIService.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import Foundation

class MockCovid19APIService: Covid19RepositoryService {
    
    lazy var stubbedGetGlobalTotalCount: Result<CaseStats, Covid19APIError> = {
        guard let caseStats: DailySummaryCaseStats = try? Bundle.main.loadAndDecodeJSON(filename: "daily_summary") else {
            return .failure(.noData)
        }
        return .success(caseStats.global)
    }()
    
    
    lazy var stubbedGetDailySummaryStats: Result<DailySummaryCaseStats, Covid19APIError> = {
        guard let caseStats: DailySummaryCaseStats = try? Bundle.main.loadAndDecodeJSON(filename: "daily_summary") else {
            return .failure(.noData)
        }
        return .success(caseStats)
    }()
    
    
    lazy var stubbedGetAllCountries: Result<[Country], Covid19APIError> = {
        guard let countries: [Country] = try? Bundle.main.loadAndDecodeJSON(filename: "country_list") else {
            return .failure(.noData)
        }
        return .success(countries)
    }()
    
    lazy var stubbedGetTotalCountByCountry: Result<CountryTotalCase, Covid19APIError> = {
        guard let totalCount: [CountryTotalCase] = try? Bundle.main.loadAndDecodeJSON(filename: "indonesia") else {
            return .failure(.noData)
        }
        return .success(totalCount.last!)
        
    }()
    
    lazy var stubbedGetCountrySummaries: Result<[CountryTotalCase], Covid19APIError> = {
        guard let totalCount: [CountryTotalCase] = try? Bundle.main.loadAndDecodeJSON(filename: "indonesia") else {
            return .failure(.noData)
        }
        return .success(totalCount)
        
    }()
    
    func getGlobalTotalCount(completion: @escaping (Result<CaseStats, Covid19APIError>) -> ()) {
        completion(stubbedGetGlobalTotalCount)
    }
    
    func getDailySummaryStats(completion: @escaping (Result<DailySummaryCaseStats, Covid19APIError>) -> ()) {
        completion(stubbedGetDailySummaryStats)
    }
    
    func getAllCountries(completion: @escaping (Result<[Country], Covid19APIError>) -> ()) {
        completion(stubbedGetAllCountries)
        
    }
    
    func getTotalCount(countryId: String, completion: @escaping (Result<CountryTotalCase, Covid19APIError>) -> ()) {
        completion(stubbedGetTotalCountByCountry)
    }
    
    func getSummaries(countryId: String, completion: @escaping (Result<[CountryTotalCase], Covid19APIError>) -> ()) {
        completion(stubbedGetCountrySummaries)
    }
    
}
