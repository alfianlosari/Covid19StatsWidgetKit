//
//  Covid19API.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 01/08/20.
//

import Foundation

enum Covid19APIError: Error {
    case invalidURL
    case invalidSerialization
    case badHTTPResponse
    case error(NSError)
    case noData
}

protocol Covid19RepositoryService {
    func getDailySummaryStats(completion: @escaping (Result<DailySummaryCaseStats, Covid19APIError>) -> ())
    func getGlobalTotalCount(completion: @escaping (Result<CaseStats, Covid19APIError>) -> ())
    func getAllCountries(completion: @escaping (Result<[Country], Covid19APIError>) -> ())
    func getTotalCount(countryId: String, completion: @escaping (Result<CountryTotalCase, Covid19APIError>) -> ())
    func getSummaries(countryId: String, completion: @escaping (Result<[CountryTotalCase], Covid19APIError>) -> ())
}

class Covid19APIService: Covid19RepositoryService  {
    
    static let shared = Covid19APIService()
    private let baseAPIURL = "https://api.covid19api.com"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
        
    private init() {}
    
    func getAllCountries(completion: @escaping (Result<[Country], Covid19APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/countries") else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndDecode(with: url, completion: completion)
    }
    
    func getDailySummaryStats(completion: @escaping (Result<DailySummaryCaseStats, Covid19APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/summary") else {
            completion(.failure(.invalidURL))
            return
        }
        
        executeDataTaskAndDecode(with: url) { (result: Result<DailySummaryCaseStats, Covid19APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getGlobalTotalCount(completion: @escaping (Result<CaseStats, Covid19APIError>) -> ()) {
        getDailySummaryStats { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.global))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSummaries(countryId: String, completion: @escaping (Result<[CountryTotalCase], Covid19APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/total/country/\(countryId)") else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndDecode(with: url, completion: completion)
    }
    
    
    func getTotalCount(countryId: String, completion: @escaping (Result<CountryTotalCase, Covid19APIError>) -> ()) {
        getSummaries(countryId: countryId) { (result) in
            switch result {
            case .success(let response):
                if let last = response.last {
                    completion(.success(last))
                } else {
                    completion(.failure(.noData))
                }
    
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func executeDataTaskAndDecode<D: Decodable>(with url: URL, completion: @escaping (Result<D, Covid19APIError>) -> ()) {
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.executeInMainThread(result: .failure(.error(error as NSError)), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                self.executeInMainThread(result: .failure(.badHTTPResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeInMainThread(result: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let model = try self.jsonDecoder.decode(D.self, from: data)
                self.executeInMainThread(result: .success(model), completion: completion)
            } catch let error as NSError{
                print(error.localizedDescription)
                self.executeInMainThread(result: .failure(.invalidSerialization), completion: completion)
            }
        }.resume()
    }
    
    private func executeInMainThread<D: Decodable>(result: Result<D, Covid19APIError>, completion: @escaping (Result<D, Covid19APIError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

