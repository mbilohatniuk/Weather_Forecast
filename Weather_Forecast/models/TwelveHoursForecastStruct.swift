//
//  TwelveHoursForecastStruct.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/10/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation

struct TwelveHoursForecastResponse: Decodable {
    let dateTime: Date
    let temperature: TemperatureOfHour

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case temperature = "Temperature"
    }
}


struct TemperatureOfHour: Decodable {
    let value: Double

    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}

