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
    
    var embededTableViewheightDelegate: extraAmenitiesTableViewHeightDeelegate?
    
    let buttonCheck = "buttonON"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customAmenities.insert(buttonCheck, at: customAmenities.count)
  
        updateHeightToParrent()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            let currentValue = customAmenities[indexPath.row]
            
            if currentValue != buttonCheck {
                
                customAmenities.remove(at: indexPath.row)
                let indexPath = IndexPath(row: indexPath.row, section: 0)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                updateHeightToParrent()
                updateFirebase()
        
            }
            
        }
    }

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
        
        cell.configureCell(text: turnButtonOn)
        
        
        cell.delegate = self
        cell.insertCellDelegate = self

        return cell
    }
    
    
    


   

}






extension AddCustomAmmenityTableViewController: addToCustomAmenitiesDelegate, insertNewCellDelegate, extraAmenitiesDelegate {
    
    func addAmenity(with amenity: String, for cell: UITableViewCell) {
        
        
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        
        customAmenities.remove(at: index)
        
        customAmenities.insert(amenity, at: index)
        
        
        updateFirebase()

    }
    
    
    func insertCell() {
  
        customAmenities.insert("", at: customAmenities.count - 1)
        
        updateHeightToParrent()
        
        tableView.reloadData()
        
        
        
    }
    
    func updatedExtraAmenities(array: [String]) {
        
        
        customAmenities = array
        
        customAmenities.insert(buttonCheck, at: customAmenities.count)
        updateHeightToParrent()
        tableView.reloadData()
    }
    
    
    
    func updateHeightToParrent() {
        let totalHeight = customAmenities.count * 60
        embededTableViewheightDelegate?.updateHeight(newHeight: totalHeight)
        
    }
    
    func updateFirebase() {
        
        let filteredArray = customAmenities.filter{$0 != buttonCheck && $0 != ""}
        
        
        appenderDelegate?.appender(key: .ExtraAmenities, value: filteredArray)
        
    }
  
    
}




