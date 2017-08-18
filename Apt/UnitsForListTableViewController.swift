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
    
    var nosubunitIndicator: String?
    
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
        
        guard let currentList = currentList, let unitToSend = units[indexPath.row].itemKey else {return}
        
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        
        
        if cell.accessoryType == .checkmark {
            
            let newSubList = currentList.assignedUnits.filter{$0 != unitToSend}
            self.currentList?.assignedUnits = newSubList

        } else {
            
            var newSubList = currentList.assignedUnits
            newSubList.append(unitToSend)
            self.currentList?.assignedUnits = newSubList
            
        }

        let listCheck = self.currentList?.assignedUnits.filter{$0 != nosubunitIndicator!}

        if listCheck?.count == 0 {
            
            self.currentList?.assignedUnits.append(nosubunitIndicator!)
            
        } else {
            let subList = self.currentList?.assignedUnits.filter{$0 != nosubunitIndicator!}
            self.currentList?.assignedUnits = subList!
           
        }
        
        
        addtoListDelegate?.addToList(for: self.currentList!)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
       
        
    }
    
    
    
    

   

}
