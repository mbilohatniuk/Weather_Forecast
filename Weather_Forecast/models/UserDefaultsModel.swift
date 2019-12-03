//
//  UserDefaultsModel.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/29/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation

class UserDefaultsModel {
    
        public func addFavouriteCities(key: String, city: City) -> [City] {
            var array = [City]()
            let decoder = JSONDecoder()
            let defaults = UserDefaults.standard
            
            if let savedCities = defaults.object(forKey: key) as? Data {
                if let loadedCities = try? decoder.decode([City].self, from: savedCities) {
                    array = loadedCities
                    array.append(city)
                    return array
                } else {
                    return array
                }
            } else {
                return array
            }
        }

    public func removeFavouriteCity(key: String, by indexPath: Int) -> [City] {
        var array = [City]()
        let decoder = JSONDecoder()
        let defaults = UserDefaults.standard

        if let savedCities = defaults.object(forKey: key) as? Data {
            if let loadedCities = try? decoder.decode([City].self, from: savedCities) {
                array = loadedCities
                array.remove(at: indexPath)
                return array
            } else {
                return array
            }
        } else {
            return array
        }
    }
        
        public func resaveFavouriteCities(key: String, array: [City]) {
        
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(array) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: key)
            }

        }
}
