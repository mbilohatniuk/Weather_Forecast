//
//  FiveDayForecast.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/8/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation

enum FetchError: Error, LocalizedError {
    case decodeError(String)
    case dataIsNill(String)
    case invalidURL(String)
    
    var errorDescription: String? {
        switch self {
        case .decodeError(let description):
            return "Error: \(description)"
        case .dataIsNill(let description):
            return "Error: \(description)"
        case .invalidURL(let description):
            return "Error: \(description)"
        }
    }
}

class FiveDayForecast: APIConfigurator {
    
    var host: String
    var APIKey: String
    var details: Bool?
    var metric: Bool?
    var cityKey: String?
    
    var detailsForAPI: String {
        return "&details=\(details!)"
    }
    
    var metricForAPI: String {
        return "&metric=\(metric!)"
    }
    
    init(host: String, APIKey: String, details: Bool? = false, metric: Bool) {
        self.host = host
        self.APIKey = APIKey
        self.details = details
        self.metric = metric
    }
    
    func fetchDailyForecasts(cityKey: String, completion: @escaping(DailyForecastsResponse) -> Void, failure: @escaping(Error) -> Void) {
        
        guard let url = URL(string: "\(self.host)/forecasts/v1/daily/5day/\(cityKey)?apikey=\(self.APIKey)\(self.detailsForAPI)\(self.metricForAPI)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(FetchError.dataIsNill(error!.localizedDescription))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let fiveDayData = try decoder.decode(DailyForecastsResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(fiveDayData)
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    failure(FetchError.decodeError(error.localizedDescription))
                }
            }
        }.resume()
    }
}

