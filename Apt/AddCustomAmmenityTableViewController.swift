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
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

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
            cell.hideTextField(isHidden: false)
         
        default:
            cell.hideTextField(isHidden: true)
        }
        
        cell.configureCell(text: turnButtonOn)
        
        
        cell.delegate = self

        return cell
    }
    
    
    
    //MARK: alertview controller

    let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
        alert -> Void in
        

        
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
        (action : UIAlertAction!) -> Void in
        
    })
    
    

    

}






extension AddCustomAmmenityTableViewController: addToCustomAmenitiesDelegate, extraAmenitiesDelegate {
    
    func addAmenity(with amenity: String, for cell: UITableViewCell) {
        
        
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        
        addTextAlert(index: index)
        
       

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

// Mark: alertController 

extension AddCustomAmmenityTableViewController {
    
    func addTextAlert(index: Int) {
        
        
        let textAlert = UIAlertController(title: "Add New Amenity", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let newAenity = textAlert.textFields![0] as UITextField
            
            let newText = newAenity.text
            
            if (newText?.characters.count)! > 0 {
                
                self.tableView.beginUpdates()
                self.customAmenities.insert(newAenity.text!, at: index)
                self.updateHeightToParrent()
                let indexPath = IndexPath(item: index, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
                self.updateFirebase()
                
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        textAlert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Amenity"
        }
     
        textAlert.addAction(saveAction)
        textAlert.addAction(cancelAction)
        
        self.present(textAlert, animated: true, completion: nil)

    
    }
    
}


    





