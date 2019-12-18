//
//  CustomCollectionViewCell.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/13/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(model: TwelveHoursForecastResponse) {
        timeLabel.text = model.dateTime.toStringTime(dateFormat: "hh:mm", timeZone: model.timeZone ?? "")
        tempLabel.text = "\(model.temperature.value)ºC"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12.0
    }

}
