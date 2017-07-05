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
    
    
    let bedrooms = ["0","1","2", "3", "4", "5", "6", "7"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
