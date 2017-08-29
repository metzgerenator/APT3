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
    
     var  propertyLists = [ListType]()
    
    var currentFilter: Filter?
    
    var ref: DatabaseReference?
    static var filterView = "Filter"
    
    var propertyFavorites = [ApartmentFavorites]()
    
    var propertyFavoriteEndpoint: DatabaseReference {

        return Endpoints.favoriteProperties.url
    }
    
    var propertyEndPoint: DatabaseReference {
        
        return Endpoints.currentUSerProperties.url
        
    }
    
    var listEndPoints: DatabaseReference {
        
        return Endpoints.lists.url
        
    }


    @IBOutlet var tableView: UITableView!
    
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "Filter", sender: self)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set automatic dimension for table view 
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 190
        
        //list for saved lists 
        
        listEndPoints.observe(.value, with: { (snapshot) in
            
            let valueDictionary = snapshot.value as? [String : Any] ?? [:]
            guard let newList = currentListTypeArray(dictionary: valueDictionary) else {return}
            //check and skip lists with no unites
            self.propertyLists = newList.filter{$0.assignedUnits[0] != PropertyKeys.NoUnitCheck.rawValue}
  

        })
        
    
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
        
        if let filterCheck = currentFilter {
            
            switch filterCheck.sortByList {
            case true:
                return propertyLists.count
            case false:
                return 1
            }
            
        } else {
            return 1
        }
        

        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let filterCheck = currentFilter {
            
            switch filterCheck.sortByList {
            case true:
                let currentList = propertyLists[section]
                return currentList.assignedUnits.count
                
            case false:
                return properties.count
    
            }
        } else {
            return properties.count
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
 
        if let filterCheck = currentFilter {

            switch filterCheck.sortByList {
            case true:
                return propertyLists[section].listName
                
            case false:
                return nil
                
            }

        } else {
            return nil
        }
    }
    
    
    //fix this for slection under filter
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //fix this
         let propertyKey = properties[indexPath.row]

        self.performSegue(withIdentifier: "propertyDetail", sender: propertyKey)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeTableViewCell
        
        cell.delegate = self
        
        if let filterCheck = currentFilter {
            
            switch filterCheck.sortByList {
            case true :
                let currentList = propertyLists[indexPath.section]
                let currentUnitID = currentList.assignedUnits[indexPath.row]
                let unit = properties.filter{$0.itemKey == currentUnitID}[0]
                
                
                if let unitKey = unit.itemKey {
                    let unitSaved = propertyFavorites.contains{$0.propertyKey == unitKey}
                    cell.changeButton(isFavorite: unitSaved)
                    
                }
                
                cell.configureCell(unit: unit)
                return cell
            case false:
                let unit = properties[indexPath.row]
                
                if let unitKey = unit.itemKey {
                    let unitSaved = propertyFavorites.contains{$0.propertyKey == unitKey}
                    cell.changeButton(isFavorite: unitSaved)
                    
                }
                cell.configureCell(unit: unit)
                
                return cell
            }
            
            
           
            
        } else {
            
            let unit = properties[indexPath.row]
            
            if let unitKey = unit.itemKey {
                let unitSaved = propertyFavorites.contains{$0.propertyKey == unitKey}
                cell.changeButton(isFavorite: unitSaved)
                
            }
            cell.configureCell(unit: unit)
            
            return cell
            
        }
        
    
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 195
        
        
    }
    
    
}


//Mark: navigation 

extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "propertyDetail" {
            
            guard let vc = segue.destination as? PropertyDetailsTableViewController, let property = sender as? Apartment, let propKey = property.itemKey else {return}
            
            vc.propertyID = Endpoints.currentUSerProperties.url.child(propKey)
            vc.listenOnceForCurrentValues()
         
            
        }
        
        
        if segue.identifier == "Filter" {
            
            guard let vc = segue.destination as? FilterViewController else {return }
            vc.filterDelegate = self
            vc.currentFilter = currentFilter
            
            
        }
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


//MARK: filtered 

extension HomeViewController: FilterCurrentView {
    
    func filterHomeView(CurrentFilter: Filter) {
       
        self.currentFilter = CurrentFilter
        tableView.reloadData()
        
    }

}


// MARK: Filter Struct


struct Filter {
    
    var highToLow: Bool
    var lowToHigh: Bool
    var sortByList: Bool

}



