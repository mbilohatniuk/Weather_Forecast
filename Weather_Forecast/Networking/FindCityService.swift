//
//  FindCity.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/15/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation

class FindCity: APIConfigurator {
    
    let host: String
    let APIKey: String
    var details: Bool?
    var metric: Bool?
    var cityKey: String?
    
    init(host: String, APIKey: String) {
        self.host = host
        self.APIKey = APIKey
    }
    
    func fetchAutocompleteCity(query: String, completion: @escaping([FoundCities]) -> Void, failure: @escaping(Error) -> Void) {
        
        guard let url = URL(string: "\(self.host)/locations/v1/cities/autocomplete?apikey=\(self.APIKey)&q=\(query)") else {
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
                let data = try JSONDecoder().decode([FoundCities].self, from: data)
                
                DispatchQueue.main.async {
                    completion(data)
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    failure(FetchError.decodeError(error.localizedDescription))
                }
            }
            
        }.resume()
    }
}
