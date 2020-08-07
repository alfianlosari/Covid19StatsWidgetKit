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
    func getGlobalTotalCount(completion: @escaping (Result<CaseStats, Covid19APIError>) -> ())
    func getAllCountries(completion: @escaping (Result<[Country], Covid19APIError>) -> ())
    func getTotalCount(countryId: String, completion: @escaping (Result<CountryTotalCase, Covid19APIError>) -> ())
}

class Covid19APIService: Covid19RepositoryService  {

    static let shared = Covid19APIService()
    private let baseAPIURL = "https://api.covid19api.com"
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
        
    private init() {}
    
    func getAllCountries(completion: @escaping (Result<[Country], Covid19APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/countries") else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndDecode(with: url, completion: completion)
    }
    
    func getGlobalTotalCount(completion: @escaping (Result<CaseStats, Covid19APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/summary") else {
            completion(.failure(.invalidURL))
            return
        }
        
        executeDataTaskAndDecode(with: url) { (result: Result<DailySummaryCaseStas, Covid19APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response.global))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTotalCount(countryId: String, completion: @escaping (Result<CountryTotalCase, Covid19APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/total/country/\(countryId)") else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndDecode(with: url) { (result: Result<[CountryTotalCase], Covid19APIError>) in
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
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error as NSError)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completion(.failure(.badHTTPResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let model = try self.jsonDecoder.decode(D.self, from: data)
                completion(.success(model))
            } catch let error as NSError{
                print(error.localizedDescription)
                completion(.failure(.invalidSerialization))
            }
        }.resume()
    }
}
