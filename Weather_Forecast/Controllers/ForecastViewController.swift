//
//  ForecastViewController.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/8/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import UIKit
//ReWUZQILbsFryFoPjvK6z6lRYMDH3pki
//jasoxQ69ZDTM0QCmJGigH40AG9iemwGG
//dqaI6T11mu6GjnsGcF2FEbZG9bLnJjU4
//2Y3QkGbwhy2MMit0vIbCJMzCp0lITYx3

struct Constant {
    
    static let heightCell: CGFloat = 300
    static let host = "http://dataservice.accuweather.com/forecasts"
    static let APIKey = "2Y3QkGbwhy2MMit0vIbCJMzCp0lITYx3"
    static let backgroundImage = UIImage(named: "background_forecast")
}

struct City: Codable{
    let key: String
    let cityName: String
    let country: String
}

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - private variables
    
    private var fiveDayForecastAPIConfig = APIElements(host: Constant.host,
                                               APIKey: Constant.APIKey,
                                               details: true,
                                               metric: true)
    
    private let twelveHoursForecastAPIConfig = APIElements(host: Constant.host,
                                                   APIKey: Constant.APIKey,
                                                   metric: true)
    
    
    private var responseDataForFiveDays: DailyForecastsResponse? {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
    private var responseDataForTwelveHours: [TwelveHoursForecastResponse]? {
        didSet {
            if isViewLoaded {
                collectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cities = [City]()
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cities) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "cities")
        }
     
        
        let favouriteButton = UIBarButtonItem(title: "Favourite Citys",
                                              style: .done,
                                              target: self,
                                              action: #selector(favouriteButtonTapped))
        
        self.navigationItem.rightBarButtonItem = favouriteButton
        
        backgroundImage.image = Constant.backgroundImage
        
        // Register table  and collection cell class from nib
        let cellNib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "WeatherTableViewCellID")
        
        let CVCellNin = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.collectionView.register(CVCellNin, forCellWithReuseIdentifier: "CVCellID")
        
        reloadScreen()
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    @objc func favouriteButtonTapped() {
        performSegue(withIdentifier: "toFavouriteCities", sender: nil)
    }
    
    //MARK: - private functions
    
    private func setHourlyForecastData(_ data: [TwelveHoursForecastResponse]) -> Void {
        responseDataForTwelveHours = data
    }
    
    private func setFiveDaysForecastData(_ data: DailyForecastsResponse) -> Void {
        responseDataForFiveDays = data
    }
    
    private func workWithError(_ error: Error) -> Void {
        print(error)
    }
}


// FILL TABLE VIEW
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constant.heightCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return responseDataForFiveDays?.dailyForecasts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCellID") as? WeatherTableViewCell,
            let data = responseDataForFiveDays?.dailyForecasts[indexPath.row]
            else {
                return UITableViewCell()
        }
        
        cell.configure(model: data)
        return cell
    }
}



//FILL COLLECTION VEIEW
extension ForecastViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return responseDataForTwelveHours?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellID", for: indexPath) as? CustomCollectionViewCell,
            let model = responseDataForTwelveHours?[indexPath.row]
            else {
                return UICollectionViewCell()
        }
        
        cell.configure(model: model)
        
        return cell
    }
}



//RELOAD MAIN SCREEN BY NEW CITY KEY
extension ForecastViewController {
    
    public func reloadScreen(whith cityKey: String = "326175") {
        
        let fiveDayForecast = FiveDayForecast(host: fiveDayForecastAPIConfig.host,
                                              APIKey: fiveDayForecastAPIConfig.APIKey,
                                              details: fiveDayForecastAPIConfig.details,
                                              metric: fiveDayForecastAPIConfig.metric!)
        
        fiveDayForecast.fetchDailyForecasts(cityKey: cityKey,
                                            completion: setFiveDaysForecastData(_:),
                                            failure: workWithError(_:))
        
        let twelveHoursForecast = TwelveHoursForecast(host: twelveHoursForecastAPIConfig.host,
                                                      APIKey: twelveHoursForecastAPIConfig.APIKey,
                                                      metric: twelveHoursForecastAPIConfig.metric!)
        
        twelveHoursForecast.fetchTwelveHoursForecasts(cityKey: cityKey,
                                                      completion: setHourlyForecastData(_:),
                                                      failure: workWithError(_:))
    }
}
