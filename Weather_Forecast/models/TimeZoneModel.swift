//
//  TimeZone.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 12/18/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation
 
struct TimeZoneModel: Decodable {
    
    let timeZone: ZoneName
    
    enum CodingKeys: String, CodingKey {
        case timeZone = "TimeZone"
    }
}

struct ZoneName: Decodable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}
