//
//  TimeZoneService.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 12/18/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation

class TimeZoneService: APIConfigurator {
    
    let host: String
    
    let APIKey: String
    
    var details: Bool?
    
    var metric: Bool?
    
    var cityKey: String?
    
    init(host: String, APIKey: String) {
        self.host = host
        self.APIKey = APIKey
    }
    
    public func fetchTimeZone(cityKey: String, completion: @escaping (TimeZoneModel) -> Void, failure: @escaping(Error) -> Void) {
        
        guard let url = URL(string: "\(host)/locations/v1/\(cityKey)?apikey=\(APIKey)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let _ = response else { return }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(FetchError.dataIsNill(error!.localizedDescription))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let dataJSON = try decoder.decode(TimeZoneModel.self, from: data)

                DispatchQueue.main.async {
                    completion(dataJSON)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(FetchError.decodeError(error.localizedDescription))
                }
            }
        }.resume()
    }
}
