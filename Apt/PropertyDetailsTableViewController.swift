//
//  PropertyDetailsTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class PropertyDetailsTableViewController: UITableViewController {
    
    var dictionaryToSave: Dictionary = [String : Any]()
    
    
    @IBOutlet var petsSwitch: UISwitch!

    @IBOutlet var bedRoomSelection: UIPickerView!
    
    @IBOutlet var bedroomNumber: UILabel!
    
    @IBOutlet var bedRoomSelectionRow: UITableViewCell!
    
    @IBOutlet var bathroomNumber: UILabel!
    
    @IBOutlet var bathroomSelectionPicker: UIPickerView!

    @IBOutlet var bathRoomSelectionRow: UITableViewCell!
 
    @IBOutlet var washerDryerType: UILabel!
    
    @IBOutlet var washerDryerSelectionRow: UITableViewCell!
    
    @IBAction func petsSwitchAction(_ sender: UISwitch) {
        
        petsSwitch.isOn = sender.isOn
        
        appender(key: .PetsAllowed, value: "\(sender.isOn)")
        
        
    }
    @IBOutlet var washerPicker: UIPickerView!
    
    let bedrooms = ["0","1","2", "3", "4", "5", "6", "7"]
    
    let washingMachines = ["None", "In Unit", "In Building", "Hookups"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        
        bedRoomSelectionRow.isHidden = true
        bathRoomSelectionRow.isHidden = true
        //washerDryerSelectionRow.isHidden = true
        
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
 

}





//MARK: tableview Methods 


extension PropertyDetailsTableViewController  {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //row 5, section 1
        
        print("row \(indexPath.row), section \(indexPath.section)")
        
        //row 2 section 0
        if indexPath.row == 2 && indexPath.section == 0 {
            
            self.performSegue(withIdentifier: "rent", sender: nil)
            
        }
        
        
        
        switch (indexPath.row, indexPath.section) {
        case (0, 1):
            
            switch bedRoomSelectionRow.isHidden {
            case (true):
                bedRoomSelectionRow.isHidden = false

                tableView.reloadData()
            default:
                bedRoomSelectionRow.isHidden = true
                tableView.reloadData()
            }
            
        case (2,1):
            switch bathRoomSelectionRow.isHidden {
            case true:
                bathRoomSelectionRow.isHidden = false
               tableView.reloadData()
            default:
                bathRoomSelectionRow.isHidden = true
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
            
        } else if indexPath.row == 3 && indexPath.section == 1 {
            
            switch bathRoomSelectionRow.isHidden {
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
        case bathroomSelectionPicker:
            return bedrooms.count
        case washerPicker:
            return washingMachines.count
        default:
            return 1
        }
    
    }
    
    
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case bedRoomSelection:
            bedroomNumber.text = bedrooms[row]
            appender(key: .BathroomNumber, value: bedrooms[row])
            
        case bathroomSelectionPicker:
            bathroomNumber.text = bedrooms[row]
            appender(key: .BedroomNumber, value: bedrooms[row])
            
        case washerPicker:
            washerDryerType.text = washingMachines[row]
            appender(key: .WasherDryerType, value: washingMachines[row])
     
        default:
            break
        }
        
    }
    
    

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case bedRoomSelection:
            return bedrooms[row]
            
        case bathroomSelectionPicker:
            return  bedrooms[row]
            
        case washerDryerType:
            return washingMachines[row]
        default:
            return ""
        }
        
    }
    
    

    
    
    
}




extension PropertyDetailsTableViewController: appendToDictionaryDelegate {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rent" {
            
            guard let nav = segue.destination as? UINavigationController, let vc = nav.topViewController as? RentTableViewController else {return}
            
            vc.delegate = self
            
            
        }
    }
    
    
    func appender(key: PropertyKeys, value: String) {
        
        dictionaryToSave.updateValue(value, forKey: key.rawValue)
        
        print("here is current dictionary \(dictionaryToSave)")
        
    }
    
}


