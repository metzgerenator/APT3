//
//  HomeViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/19/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var properties = [Apartment]()
    var ref: DatabaseReference?
    
    var propertyFavorites = [ApartmentFavorites]()
    
    var propertyFavoriteEndpoint: DatabaseReference {

        return Endpoints.favoriteProperties.url
    }
    
    var propertyEndPoint: DatabaseReference {
        
        return Endpoints.currentUSerProperties.url
        
    }


    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set automatic dimension for table view 
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 190
        
    
        propertyEndPoint.observe(.value, with: { (snapshot) in

            let valueDictionary = snapshot.value as? [String : Any] ?? [:]
            
            let arrayOfUnites = ApartmentArray.init(dictionary: valueDictionary)
            
            self.properties = arrayOfUnites.apartments
            self.tableView.reloadData()
            
        })
        
      
        //listener for duplicate properties 
        
        propertyFavoriteEndpoint.observe(.value, with: { (snapShot) in
            
            let valueDictionary = snapShot.value as? [String : Any] ?? [:]
            self.propertyFavorites = CurrentApartmentFavorites(dictionary: valueDictionary).currentFavoriets
            self.tableView.reloadData()
            
        })
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}



//MARK: tableViewMethods


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeTableViewCell
        
        let unit = properties[indexPath.row]
        
        if let unitKey = unit.itemKey {
            let unitSaved = propertyFavorites.contains{$0.propertyKey == unitKey}
            cell.changeButton(isFavorite: unitSaved)
            
        }
        
        
        cell.delegate = self
        
        cell.configureCell(unit: unit)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 195
        
        
    }
    
    
}

//MARK: protocols 

extension HomeViewController: likeButtonDelegate {
    
    
    func unitisLiked (unitLiked: Bool, unit: Apartment) {
        guard let itemKey = unit.itemKey else {return}
        let url = propertyFavoriteEndpoint.childByAutoId()
        
        let isAlreadyFavorite = propertyFavorites.contains{$0.propertyKey == itemKey}
        
        
        if isAlreadyFavorite {
            
            
            for subUnit in propertyFavorites {
                
                if subUnit.propertyKey == itemKey {
                
                    let removeURL = propertyFavoriteEndpoint.child(subUnit.urlKey)
                    Endpoints.removeFromExisting(with: removeURL)
                }
                
            }
    
        } else {
            
            let inputDictionary = [PropertyKeys.PropertyKey.rawValue : itemKey]
            
            Endpoints.appendToExisting(with: url, values: inputDictionary)
            
        }
    
        
    }
    
}



