//
//  PropertyDetailsTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class PropertyDetailsTableViewController: UITableViewController {

    @IBOutlet var bedRoomSelection: UIPickerView!
    
    @IBOutlet var bedroomNumber: UILabel!
    
    @IBOutlet var bedRoomSelectionRow: UITableViewCell!
    
    let bedrooms = ["0","1","2", "3", "4", "5", "6", "7"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
 

}





//MARK: tableview Methods 


extension PropertyDetailsTableViewController  {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.row, indexPath.section) {
        case (0, 1):
            
            
            switch bedRoomSelectionRow.isHidden {
            case true:
                bedRoomSelectionRow.isHidden = false
                tableView.reloadData()
            default:
                 bedRoomSelectionRow.isHidden = true
                tableView.reloadData()
            }
        default:
            return
        }
        
        
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        
        if indexPath.row == 1 && indexPath.section == 1 {
            
            switch bedRoomSelectionRow.isHidden {
            case true:
                return 0
            case false:
                return UITableViewAutomaticDimension
            }
            
        } else {
            return UITableViewAutomaticDimension
        }
        
    }

    
    
    
}






//MARK: picker methods

extension PropertyDetailsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        

        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case bedRoomSelection:
            return bedrooms.count
        default:
            return 1
        }
    
    }
    
    
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case bedRoomSelection:
            bedroomNumber.text = bedrooms[row]
        default:
            break
        }
        
    }
    
    

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case bedRoomSelection:
            return bedrooms[row]
        default:
            return ""
        }
        
    }
    
    

    
    
    
}
