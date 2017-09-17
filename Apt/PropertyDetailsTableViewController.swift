//
//  PropertyDetailsTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON


class PropertyDetailsTableViewController: UITableViewController {
    
    
    
    
    
    @IBAction func coverPhotoAction(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "cameraControl", sender: self)
        
        
    }
    
    
    @IBOutlet var coverPhoto: UIImageView!
    
    var headerView: UIView!
    var newHeaderLayer: CAShapeLayer!
    
    var dictionaryToSave: Dictionary = [String : Any]()
    var propertyPhotosDictionary = [String : Any]()
    
    var extraAmenitiesTableViewHeight = 44
 
    var propertyID: DatabaseReference?
    
    var extraAmenitiesDelegate: extraAmenitiesDelegate?
    
    
    @IBOutlet var currentAddressLabel: UILabel!
    
    
    @IBOutlet var currentRentLabel: UILabel!
    
    @IBOutlet var headerHeightConstraint: NSLayoutConstraint!
  
    
    
    @IBOutlet var apartmentNameOutlet: UITextField!
    
     var unitName: String?
    
    @IBAction func ApartmentNameChange(_ sender: UITextField) {
        
        
        if let nameUpdate = sender.text {
            
            if nameUpdate.characters.count > 0 {
                
                appender(key: .PropertyName, value: nameUpdate)
                
            }
            
        }
        
        
        
    }
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     coverPhoto.contentMode = .scaleAspectFill
    coverPhoto.clipsToBounds = true
        
        if let unitName = unitName{
            apartmentNameOutlet.text = unitName
        }
        

        if let url = propertyID {
            
           // MARK: init other property details here
            
            url.observe(.value, with: { (snapshot) in
                
                let valueDictionary = snapshot.value as? [String : Any] ?? [:]
                
                self.updatePhotoValues(dictionary: valueDictionary)
       
            })
            
            
        }
        
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        
        bedRoomSelectionRow.isHidden = true
        bathRoomSelectionRow.isHidden = true
        washerDryerSelectionRow.isHidden = true
        
        //Mark: scroll to top here!
        
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
 

}







//MARK: tableview Methods 


extension PropertyDetailsTableViewController: extraAmenitiesTableViewHeightDeelegate  {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        if indexPath.row == 1 && indexPath.section == 0 {
            
            self.performSegue(withIdentifier: "addressSearch", sender: nil)
            
        }
        
        
        if indexPath.row == 2 && indexPath.section == 0 {
            
            self.performSegue(withIdentifier: "rent", sender: nil)
            
        }
        
        
        
        switch (indexPath.row, indexPath.section) {
        case (5, 1):
            
            switch washerDryerSelectionRow.isHidden {
            case (true):
                washerDryerSelectionRow.isHidden = false
                
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.scrollToNearestSelectedRow(at:.top , animated: true)
                
            default:
                washerDryerSelectionRow.isHidden = true
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.scrollToNearestSelectedRow(at: .top, animated: true)
                
            }
            
        case (0, 1):
            
            switch bedRoomSelectionRow.isHidden {
            case (true):
                bedRoomSelectionRow.isHidden = false
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.scrollToNearestSelectedRow(at:.top , animated: true)
                
            default:
                bedRoomSelectionRow.isHidden = true
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.scrollToNearestSelectedRow(at:.top , animated: true)
                
            }
            
        case (2,1):
            switch bathRoomSelectionRow.isHidden {
            case true:
                bathRoomSelectionRow.isHidden = false
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.scrollToNearestSelectedRow(at:.top , animated: true)
            default:
                bathRoomSelectionRow.isHidden = true
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.scrollToNearestSelectedRow(at:.top , animated: true)
            }
            
            
        default:
            return
        }
   
    }
    
    
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //here is row 6,   here is section 1
 
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
            
        } else if indexPath.row == 6 && indexPath.section == 1 {
            
            switch washerDryerSelectionRow.isHidden {
            case true:
                
               return 0
                
            case false:
               
                return UITableViewAutomaticDimension
     
            }
                
            
            
        
        }
            
            //add protocol to update total height of cells
            //fix this to dynamicRowHeight
        else if indexPath.row == 7 && indexPath.section == 1 {
            
             return CGFloat(extraAmenitiesTableViewHeight)
        }
        else {
            return UITableViewAutomaticDimension
        }
        
        


        
    }
    
    
    func updateHeight(newHeight: Int) {
        
        extraAmenitiesTableViewHeight = newHeight
        tableView.beginUpdates()
        tableView.endUpdates()
        //tableView.scrollToNearestSelectedRow(at: .top, animated: true)
        let indexPath = IndexPath(row: 7, section: 1)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        
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
            appender(key: .BedroomNumber, value: bedrooms[row])
            
        case bathroomSelectionPicker:
            bathroomNumber.text = bedrooms[row]
            appender(key: .BathroomNumber, value: bedrooms[row])
            
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
            
        case washerPicker:
            return washingMachines[row]
        default:
            return ""
        }
        
    }
    
    

    
    
    
}


// protocal extensions

extension PropertyDetailsTableViewController: appendToDictionaryDelegate, ClearPhotoDictionaryDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "amenities" {
            
            guard let vc = segue.destination as? AddCustomAmmenityTableViewController else {return}
            vc.appenderDelegate = self
            extraAmenitiesDelegate = vc
            vc.embededTableViewheightDelegate = self
            
            
        }
        
        
        
        if segue.identifier == "addressSearch" {
            
            guard let vc = segue.destination as? SelectLocationViewController else {return}
            vc.delegate = self
            
        }
        
        
        if segue.identifier == "cameraControl" {
            
            guard let nav = segue.destination as? UINavigationController, let vc = nav.topViewController as? PropertyPhotosViewController else {return}
     
            vc.delegate = self
            vc.removeDictonaryValuesDelagate = self
            
            if let refernce = propertyID {
    
                vc.propertyReference = refernce
            }
       
        }
        
        
        if segue.identifier == "rent" {
            
            //pass dictionary to update rent values and frequency  here
            
            guard let nav = segue.destination as? UINavigationController, let vc = nav.topViewController as? RentTableViewController else {return}
            
            vc.delegate = self
            
            
        }
    }
    
    
    func appender(key: PropertyKeys, value: Any) {
        
        dictionaryToSave.updateValue(value, forKey: key.rawValue)
        
        
        
        if let endPointID = propertyID {
            
            Endpoints.appendToExisting(with: endPointID, values: dictionaryToSave)
            
        } else {
            propertyID = Endpoints.appendPropertyValues(dictionaryToSave)
        }
  
        
    }
    
    
    func remoteSegue(){
        
        self.performSegue(withIdentifier: "cameraControl", sender: self)
        
    }
    
    
    func clearDitionary(key: String) {
        
        loadPhoto(image: Childs.clearCover.rawValue)
        
        dictionaryToSave.removeValue(forKey: key)
        propertyPhotosDictionary.removeValue(forKey: key)
        
    }
    
    
  
}




//MARK: update dictionary values

extension PropertyDetailsTableViewController {
    
    func updatePhotoValues(dictionary: [String : Any]) {
        
        let photoURLS = ObServedPhotos.init(dictionary: dictionary)
        
        if let photoArray = photoURLS.photos {
            
            for photoOBject in photoArray {
                
                self.propertyPhotosDictionary.updateValue(photoOBject.downLoadPath, forKey: photoOBject.photoCaption)
                
            }
            self.dictionaryToSave.updateValue(self.propertyPhotosDictionary, forKey: PropertyKeys.PropertyPhotos.rawValue)
        }
        
        
        
        if let bacgroundURL = photoURLS.coverPhotoURL, let caption = photoURLS.coverPhotoCaption {
            self.loadPhoto(image: bacgroundURL)
            
            
            let coverPhotoDic = [caption : bacgroundURL]
            
            self.dictionaryToSave.updateValue(coverPhotoDic, forKey: PropertyKeys.CoverPhoto.rawValue)
            
            
        }

        
    }
    
    
    
    
    
    
    
    func listenOnceForCurrentValues() {
        
        if let url = propertyID {
            
            
            url.observeSingleEvent(of: .value, with: { (snapshot) in
                let valueDictionary = snapshot.value as? [String : Any] ?? [:]

                self.updateGeneralValues(key: snapshot.key, dictionary: valueDictionary)
            })
         
            
        }
 
        
    }
    
    func loadPhoto(image: String) {
        
        if image == Childs.clearCover.rawValue {
            
            coverPhoto.image = nil
            
        } else {
            
            let url = URL(string: image)
            let placeholderImage = #imageLiteral(resourceName: "test")
            
            coverPhoto.sd_setImage(with: url, placeholderImage: placeholderImage)
            //coverPhoto.clipsToBounds = true
            
        }
        
        
        
        
    }
    
    
    
    func updateGeneralValues(key: String,dictionary: [String : Any]) {
        
        let json = JSON(dictionary)
  
        
        let singleUnite = newApartmentType(key: key, json: json)
        
        
        
        if let extraAmenities = singleUnite.extraAmenities {
            
            
            dictionaryToSave.updateValue(extraAmenities, forKey: PropertyKeys.ExtraAmenities.rawValue)
            
            extraAmenitiesDelegate?.updatedExtraAmenities(array: extraAmenities)
            
            
        }
        
        if let unitName = singleUnite.apartmentName {
            
            dictionaryToSave.updateValue(unitName, forKey: PropertyKeys.PropertyName.rawValue)
            
            apartmentNameOutlet.text = unitName
            
            
        }
        
        if let rentPrice = singleUnite.price, let frequency = singleUnite.RentFrequency {
            
            currentRentLabel.text = "\(rentPrice), \(frequency)"
            
            dictionaryToSave.updateValue(rentPrice, forKey: PropertyKeys.RentPrice.rawValue)
            dictionaryToSave.updateValue(frequency, forKey: PropertyKeys.RentFrequency.rawValue)
            
        } else {
            currentRentLabel.text  = "?"
            
        }
        
        
        if let bedrooms = singleUnite.numberOfBedrooms {
            dictionaryToSave.updateValue(bedrooms, forKey: PropertyKeys.BedroomNumber.rawValue)
            
            bedroomNumber.text = bedrooms
            
            
        }
        
        if let bathrooms = singleUnite.numberOfBathrooms {
            dictionaryToSave.updateValue(bathrooms, forKey: PropertyKeys.BathroomNumber.rawValue)
            
            bathroomNumber.text = bathrooms
            
            
        }
        
        
        if let pets = singleUnite.petsAllowed {
            
            dictionaryToSave.updateValue("\(pets)", forKey: PropertyKeys.PetsAllowed.rawValue)
            
            petsSwitch.isOn = pets
            
        }
        
        
        if let washer = singleUnite.washingMachineType {
            
            washerDryerType.text = washer
            dictionaryToSave.updateValue(washer, forKey: PropertyKeys.WasherDryerType.rawValue)
            
        }
    
        
        if let address = singleUnite.location {
            
            currentAddressLabel.text = address.address

            let locationDic =  [PropertyKeys.Address.rawValue : address.address, PropertyKeys.Latitude.rawValue : String(address.latitude), PropertyKeys.Longitude.rawValue : String(address.longitude)]
            dictionaryToSave.updateValue(locationDic, forKey: PropertyKeys.UserLocation.rawValue)
            
        } else {
            
            currentAddressLabel.text = "?"
            
        }
        
        
        
        
        
    }
    
    
}

















