//
//  Alert.swift
//  Weather_Forecast
//
//  Created by Maksym Bilohatniuk on 12/4/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    static func presentAddAlert(on vc: UIViewController, city: String, toDoCompletion1: @escaping(Int) -> Void, toDoCompletion2:  @escaping(Int) -> Void, indexPath: Int) {
        
        let alertController = UIAlertController(title: "Add City",
                                                message: "Do you whant add \"\(city)\" to your list?",
                                                preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "Add", style: .default) { _ in
            toDoCompletion1(indexPath)
            toDoCompletion2(indexPath)
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okBtn)
        alertController.addAction(cancelBtn)
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    static func presentRemoveAction(on vc: UIViewController, completionAction: @escaping(IndexPath) -> Void, indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Are you sure",
                                                message: "Delete city?",
                                                preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "Remove", style: .default) { _ in
            completionAction(indexPath)
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okBtn)
        alertController.addAction(cancelBtn)
        
        vc.present(alertController, animated: true, completion: nil)
    }
}
