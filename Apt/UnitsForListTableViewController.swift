//
//  UnitsForListTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 8/17/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import Firebase

class UnitsForListTableViewController: UITableViewController {
    
    
    var units = [Apartment]()
    
    var currentList: ListType?
    
    var addtoListDelegate: passListToListView?
    
    var propertyEndPoint: DatabaseReference {
        
        return Endpoints.currentUSerProperties.url
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        propertyEndPoint.observe(.value, with: { (snapshot) in
            
            let valueDictionary = snapshot.value as? [String : Any] ?? [:]
            
            let arrayOfUnites = ApartmentArray.init(dictionary: valueDictionary).apartments
            
            self.units = arrayOfUnites
            
            
            self.tableView.reloadData()
 
        })

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        
        let unitName = units[indexPath.row]
        
        if let keyCheck = unitName.itemKey, let presentList = currentList {
            
            let isPresent = presentList.assignedUnits.contains{$0 == keyCheck}
            
            switch isPresent {
            case true:
                cell?.accessoryType = .checkmark
            default:
                cell?.accessoryType = .none
            }
            
        }
        
        cell?.textLabel?.text = unitName.apartmentName ?? "no name"
        
        return cell!
   
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        
        let unitToSend = units[indexPath.row]
        
        if cell.accessoryType == .checkmark {
            
            
        } else {
            
            
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        
        addtoListDelegate?.addToList(unit: unitToSend)
        
        
        
        
    }
    
    
    
    

   

}
