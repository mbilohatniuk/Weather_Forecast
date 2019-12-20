//
//  АoundСtiesStruct.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/15/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation

struct FoundCities: Decodable {
    let key: String
    let cityName: String
    let country: Country
    
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case cityName = "LocalizedName"
        case country = "Country"
    }
}

struct Country: Decodable {
    let countryName: String
    
    enum CodingKeys: String, CodingKey {
        case countryName = "LocalizedName"
    }
}
