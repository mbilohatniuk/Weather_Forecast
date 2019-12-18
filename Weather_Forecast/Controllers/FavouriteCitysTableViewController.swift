//
//  FavouriteCitysTableViewController.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/14/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//



import UIKit

class FavouriteCitysTableViewController: UITableViewController {
    
    //MARK: - private variabels
    private let userDefaultsKey = "cities"
    private var userDefaultsModel = UserDefaultsModel()
    private var arrayOfFavouriteCities = [City]()
    
    @IBOutlet var favouriveTableView: UITableView!
    
    @IBOutlet weak var noFavouriteCitiesMassage: UIView!
    //MARK: - ViewController lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let findCityButton = UIBarButtonItem(title: "Find City", style: .done, target: self, action: #selector(favouriteButtonTapped))
        
        self.navigationItem.rightBarButtonItem = findCityButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            reloadData()
        
        if arrayOfFavouriteCities.count > 0 {
            noFavouriteCitiesMassage.isHidden = true
        } else {
            noFavouriteCitiesMassage.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favouriveTableView.reloadData()
    }
    
    @objc func favouriteButtonTapped() {
        performSegue(withIdentifier: "addCity", sender: nil)
    }
    
    
    //MARK: - Private functions
    
    private func removeCity(indexPath: IndexPath) {
        arrayOfFavouriteCities = userDefaultsModel.removeFavouriteCity(key: userDefaultsKey, by: indexPath.row)
        userDefaultsModel.resaveFavouriteCities(key: userDefaultsKey, array: arrayOfFavouriteCities)
        reloadData()
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    private func reloadData() {
        let defaults = UserDefaults.standard
        if let savedCities = defaults.object(forKey: "cities") as? Data {
            let decoder = JSONDecoder()
            if let loadedCities = try? decoder.decode([City].self, from: savedCities) {
                if loadedCities.count > 0 {
                    arrayOfFavouriteCities = loadedCities
                }
            } else {
                print("ERROR")
            }
        }
    }
}

//MARK: - Table View Extention
extension FavouriteCitysTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfFavouriteCities.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath)
        
        if arrayOfFavouriteCities.count > 0 {
            
            cell.textLabel?.text = "\(arrayOfFavouriteCities[indexPath.row].cityName),\(arrayOfFavouriteCities[indexPath.row].country)"
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let forecastVC = navigationController?.viewControllers
            .compactMap({ $0 as? ForecastViewController})
            .first
            else { return }
        
        forecastVC.cityNameLabel.text = "\(arrayOfFavouriteCities[indexPath.row].cityName)"
        forecastVC.reloadScreenData(whith: arrayOfFavouriteCities[indexPath.row].key)
        navigationController?.popToViewController(forecastVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Alert.presentRemoveAction(on: self, completionAction: removeCity(indexPath:), indexPath: indexPath)
        }
    }
}
