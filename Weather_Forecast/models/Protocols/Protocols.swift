//
//  Protocols.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/15/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation

protocol APIConfigurator {
    var host: String { get }
    var APIKey: String { get }
    var details: Bool? { get }
    var metric: Bool? { get }
    var cityKey: String? { get }
}
