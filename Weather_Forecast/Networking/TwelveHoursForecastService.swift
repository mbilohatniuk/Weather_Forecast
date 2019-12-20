//
//  TwelveHoursForecast.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/10/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation


//
//  FiveDayForecast.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/8/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation
// add   get cityKeys

class TwelveHoursForecastServive: APIConfigurator {
    
    
    
    let host: String
    let APIKey: String
    var details: Bool?
    var metric: Bool?
    var cityKey: String?
    
    var metricForAPI: String {
        return "&metric=\(metric!)"
    }
    
    init(host: String, APIKey: String, metric: Bool) {
        self.host = host
        self.APIKey = APIKey
        self.metric = metric
    }
    
    
    func fetchTwelveHoursForecasts(cityKey: String, completion: @escaping([TwelveHoursForecastModel]) -> Void, failure: @escaping(Error) -> Void) {
        guard let url = URL(string: "\(self.host)/forecasts/v1/hourly/12hour/\(cityKey)?apikey=\(self.APIKey)\(self.metricForAPI)") else {
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
                let dataJSON = try decoder.decode([TwelveHoursForecastModel].self, from: data)
                
                DispatchQueue.main.async {
                    completion(dataJSON)
                }
            } catch let error {
                DispatchQueue.main.async {
                    failure(FetchError.decodeError(error.localizedDescription))
                }
            }
        }.resume()
    }
}


