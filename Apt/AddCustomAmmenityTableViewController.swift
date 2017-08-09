//
//  AddCustomAmmenityTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 8/9/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class AddCustomAmmenityTableViewController: UITableViewController {
    
    var customAmenities = [String]()
    
    var appenderDelegate: appendToDictionaryDelegate?
    
    let buttonCheck = "buttonON"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customAmenities.insert(buttonCheck, at: customAmenities.count)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customAmenities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddAmenityTableViewCell
        
        let turnButtonOn = customAmenities[indexPath.row]
        
        switch turnButtonOn {
        case buttonCheck:
            cell.hideTextField(isHidden: true)
        default:
            cell.hideTextField(isHidden: false)
        }
        
        
        cell.delegate = self
        cell.insertCellDelegate = self

        return cell
    }


   

}


extension AddCustomAmmenityTableViewController: addToCustomAmenitiesDelegate, insertNewCellDelegate {
    
    func addAmenity(with amenity: String, for cell: UITableViewCell) {
        
        
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        
        customAmenities.remove(at: index)
        
        customAmenities.insert(amenity, at: index)
        
        
        let filteredArray = customAmenities.filter{$0 != buttonCheck && $0 != ""}
        
        
        appenderDelegate?.appender(key: .ExtraAmenities, value: filteredArray)


    }
    
    
    func insertCell() {
  
        customAmenities.insert("", at: customAmenities.count - 1)
        tableView.reloadData()
        
        
    }
    
    
    
}
