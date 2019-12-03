//
//  FindCityViewController.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 11/15/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import UIKit


class FindCityViewController: UIViewController {
    
    //MARK: - private variabels
    private let userDefaultsKey = "cities"
    private var responseCities: [FoundCities]?
    private var resultOfUserRequest = [FoundCities]()
    private let searchController = UISearchController(searchResultsController: nil)
    private let service = FindCity(host: "http://dataservice.accuweather.com/locations", APIKey: Constant.APIKey)
    
    @IBOutlet weak var tableView: UITableView!
    

    
    //MARK: - ViewContriller lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchControllerSetup(searchController)
        
        let cellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "findCityCell")
    }
    
    //MARK: - Private functions
    
    private func searchControllerSetup(_ searchController: UISearchController) {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find city..."
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func workWhithData(data: [FoundCities]) {
        responseCities = data
    }
    
    private func workWhithError(error: Error) {
        print(error)
    }
}
//MARK: - TableView delegate & dataSourse implementation

extension FindCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultOfUserRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "findCityCell", for: indexPath) as! SearchTableViewCell
        
        if resultOfUserRequest.count > 0 {
            
            let city = resultOfUserRequest[indexPath.row]
            cell.configure(model: city)
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDefaultsModel = UserDefaultsModel()
        let city = City(key: resultOfUserRequest[indexPath.row].key,
                        cityName: resultOfUserRequest[indexPath.row].cityName,
                        country: resultOfUserRequest[indexPath.row].country.countryName)

        
        let array = userDefaultsModel.addFavouriteCities(key: userDefaultsKey,
                                                         city: city)
        
        userDefaultsModel.resaveFavouriteCities(key: userDefaultsKey,
                                                array: array)
        guard let forecastVC = self.navigationController?.viewControllers
            .map({ $0 as? ForecastViewController })
            .compactMap({ $0 })
            .first
            else { return }

        forecastVC.reloadScreen(whith: resultOfUserRequest[indexPath.row].key)
        navigationController?.popToViewController(forecastVC, animated: true)
    }
    
}

//MAKR: - Search method implementation
extension FindCityViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        
        if text.count >= 2 {
            service.fetchFindCity(query: text, completion: updateTableView(whith:), failure: workWhithError(error:))
        } else {
            resultOfUserRequest.removeAll()
            tableView.reloadData()
        }
    }
    
    private func updateTableView(whith cities:[FoundCities]) {
        
        resultOfUserRequest = cities
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
