//
//  SearchTableViewCell.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/15/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(model: FoundCities) {
        searchLabel.text = "\(model.cityName),\(model.country.countryName)"
    }
}
