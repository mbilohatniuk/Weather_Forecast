//
//  SearchTableViewCell.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/15/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    func configure(model: FoundCities) {
        cityLabel.text = "\(model.cityName),\(model.country.countryName)"
    }
}
