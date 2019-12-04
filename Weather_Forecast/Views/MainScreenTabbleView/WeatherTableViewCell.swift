//
//  WeatherTableViewCell.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/10/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import UIKit

fileprivate class Constatnts {
    
    static let dateFormatTime = "hh:mm"
    static let dateFormatDate = "yyyy-MM-dd"
    static let rainImage = UIImage(named: "rain")
    static let thunderImage = UIImage(named: "thunder")
    static let snowImage = UIImage(named: "snow")
    static let headlerImage = UIImage(named: "headler_icon")
    static let sunRiseImage = UIImage(named: "sunRise")
    static let sunSetImage = UIImage(named: "sunSet")
    static let dayImage = UIImage(named: "day_icon")
    static let nightImage = UIImage(named: "night_icon")
}

class WeatherTableViewCell: UITableViewCell {
     //MARK: - Outlets
    @IBOutlet weak var headlerImage: UIImageView!
    @IBOutlet weak var sunRiseImage: UIImageView!
    @IBOutlet weak var sunSetImage: UIImageView!
    @IBOutlet weak var sunRiseTime: UILabel!
    @IBOutlet weak var sunSetTime: UILabel!
    @IBOutlet weak var dayImage: UIImageView!
    @IBOutlet weak var nightImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    @IBOutlet weak var iconNightPhrase: UILabel!
    @IBOutlet weak var iconDayPhrase: UILabel!
    @IBOutlet weak var dayTemperature: UILabel!
    @IBOutlet weak var nightTemperature: UILabel!
    @IBOutlet weak var nightWind: UILabel!
    @IBOutlet weak var dayWind: UILabel!
    
    
    @IBOutlet weak var nightRainProbabilityStack: UIStackView!
    
    @IBOutlet weak var nightThunderstormProbabilityStack: UIStackView!
    @IBOutlet weak var nightSnowProbabilityStack: UIStackView!
    
    @IBOutlet weak var nightRainProbabilityImage: UIImageView!
    @IBOutlet weak var nightRainProbabilityLabel: UILabel!
    
    @IBOutlet weak var nightThunderstormProbabilityImage: UIImageView!
    @IBOutlet weak var nightThunderstormProbabilityLabel: UILabel!
    
    @IBOutlet weak var nightSnowProbabilityImage: UIImageView!
    @IBOutlet weak var nightSnowProbabilityLabel: UILabel!
    
    
    @IBOutlet weak var dayRainProbabilityStack: UIStackView!
    @IBOutlet weak var dayThunderstormProbabilityStack: UIStackView!
    @IBOutlet weak var daySnowProbabilityStack: UIStackView!
    
    @IBOutlet weak var dayRainProbabilityImage: UIImageView!
    @IBOutlet weak var dayRainProbabilityLabel: UILabel!
    
    @IBOutlet weak var dayThunderstormProbabilityImage: UIImageView!
    @IBOutlet weak var dayThunderstormProbabilityLabel: UILabel!
    
    @IBOutlet weak var daySnowProbabilityImage: UIImageView!
    @IBOutlet weak var daySnowProbabilityLabel: UILabel!
    
    static let height: CGFloat = 300
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 35
        nightRainProbabilityStack.isHidden = true
        nightThunderstormProbabilityStack.isHidden = true
        nightSnowProbabilityStack.isHidden = true
        dayRainProbabilityStack.isHidden = true
        dayThunderstormProbabilityStack.isHidden = true
        daySnowProbabilityStack.isHidden = true
    }
    
    func configure(model: DailyForecast) {
        
        headlerImage.image = Constatnts.headlerImage
        sunRiseImage.image = Constatnts.sunRiseImage
        sunSetImage.image = Constatnts.sunSetImage
        dayImage.image = Constatnts.dayImage
        nightImage.image = Constatnts.nightImage
        sunRiseTime.text = model.sun.rise.toStringTime(dateFormat: Constatnts.dateFormatTime)
        sunSetTime.text = model.sun.sunSet.toStringTime(dateFormat: Constatnts.dateFormatTime)
        titleLabel.text = model.date.toStringDate(dateFormat: Constatnts.dateFormatDate)
        minMaxTempLabel.text = "\(model.temperature.minimum.value) - \(model.temperature.maximum.value)ºC"
        iconDayPhrase.text = model.day.iconPhrase
        iconNightPhrase.text = model.night.iconPhrase
        dayTemperature.text = "\(model.temperature.maximum.value)ºC"
        nightTemperature.text = "\(model.temperature.minimum.value)ºC"
        dayWind.text = "\(model.day.wind.speed.value)\(model.day.wind.speed.unit)"
        nightWind.text = "\(model.night.wind.speed.value)\(model.night.wind.speed.unit)"
        
        probabilityForecast(model: model)
    }
    
    //MARK: private functions
    private func probabilityForecast (model: DailyForecast) {
        
        if model.day.rainProbability > 15 {
            dayRainProbabilityStack.isHidden = false
            dayRainProbabilityImage.image = Constatnts.rainImage
            dayRainProbabilityLabel.text = "\(model.day.rainProbability)%"
        }
        
        if model.day.thunderstormProbability > 15 {
            dayThunderstormProbabilityStack.isHidden = false
            dayThunderstormProbabilityImage.image = Constatnts.thunderImage
            dayThunderstormProbabilityLabel.text = "\(model.day.thunderstormProbability)%"
        }
        
        if model.day.snowProbability > 15 {
            daySnowProbabilityStack.isHidden = false
            daySnowProbabilityImage.image = Constatnts.snowImage
            daySnowProbabilityLabel.text = "\(model.day.rainProbability)%"
        }
        
        if model.night.rainProbability > 15 {
            nightRainProbabilityStack.isHidden = false
            nightRainProbabilityImage.image = Constatnts.rainImage
            nightRainProbabilityLabel.text = "\(model.night.rainProbability)%"
        }
        
        if model.night.thunderstormProbability > 15 {
            nightThunderstormProbabilityStack.isHidden = false
            nightThunderstormProbabilityImage.image = Constatnts.thunderImage
            nightThunderstormProbabilityLabel.text = "\(model.night.rainProbability)%"
        }
        
        if model.night.snowProbability > 15 {
            daySnowProbabilityStack.isHidden = false
            daySnowProbabilityImage.image = Constatnts.snowImage
            daySnowProbabilityLabel.text = "\(model.night.rainProbability) %"
        }
    }
}
//MARK: - Date Extention
extension Date {
    func toStringDate( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func toStringTime( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
