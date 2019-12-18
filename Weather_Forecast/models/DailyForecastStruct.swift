//
//  DailyForecastStruct.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/8/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation
 
struct DailyForecastsResponse: Decodable {
    var dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct DailyForecast: Decodable {
    let date: Date
    let sun: Sun
    let temperature: Temperature
    let day, night: Day
    
    var timeZone: String?


    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sun = "Sun"
    }
}

struct Day: Decodable {
    let iconPhrase: String
    let thunderstormProbability, rainProbability, snowProbability: Int
    let wind: Wind


    enum CodingKeys: String, CodingKey {
        case iconPhrase = "IconPhrase"
        case thunderstormProbability = "ThunderstormProbability"
        case rainProbability = "RainProbability"
        case snowProbability = "SnowProbability"
        case wind = "Wind"
    }
}

struct Wind: Decodable {
    let speed: Speed

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
    }
}

struct Speed: Decodable {
    let value: Double
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}

struct Temperature: Decodable {
    let minimum: Minimum
    let maximum: Maximum
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

struct Minimum:Decodable {
    var value: Double
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}

struct Maximum :Decodable{
    var value: Double
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}

struct Sun: Decodable {
    let rise: Date
    let sunSet: Date

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case sunSet = "Set"
    }
}


