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
    
    var propertyEndpoint: DatabaseReference {

        return Endpoints.favoriteProperties.url
    }


    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set automatic dimension for table view 
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 190
        
        
       let propertyEndPoint = Endpoints.currentUSerProperties.url
        
        propertyEndPoint.observe(.value, with: { (snapshot) in

            let valueDictionary = snapshot.value as? [String : Any] ?? [:]
            
            let arrayOfUnites = ApartmentArray.init(dictionary: valueDictionary)
            
            self.properties = arrayOfUnites.apartments
            self.tableView.reloadData()
            
        })
        
      
        //listener for duplicate properties 
        
        propertyEndpoint.observe(.value, with: { (snapShot) in
            
            let valueDictionary = snapShot.value as? [String : Any] ?? [:]
            let arrayOffavorites = CurrentApartmentFavorites(dictionary: valueDictionary)
            
            print("print fav dictionary \(arrayOffavorites)")
            
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
    
    //first read once then unlike
    
    func unitisLiked (unitLiked: Bool, unit: Apartment) {
        
        let url = propertyEndpoint.childByAutoId()
        guard let itemKey = unit.itemKey else {return}
        
        let inputDictionary = [PropertyKeys.PropertyKey.rawValue : itemKey]
        
        Endpoints.appendToExisting(with: url, values: inputDictionary)
        
        
        
    }
    
}



