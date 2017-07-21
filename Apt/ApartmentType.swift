//
//  ApartmentType.swift
//  Apt
//
//  Created by Michael Metzger  on 7/19/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Apartment {
    
    var itemKey: String?
    var apartmentName: String?
    var coverPhotoURL: String?
    var price: String?
    var location: String?
    
    //missing 
    
    var petsAllowed: Bool?
    var washingMachineType: String?
    var RentFrequency: String?
    var RentPrice: String?
    var numberOfBedrooms: String?
    var numberOfBathrooms: String?
    
    
    init() {
        
    }


}

func newApartmentType(key: String, json: JSON) -> Apartment {
    
    var newUnit = Apartment.init()
    newUnit.itemKey = key
    
    
    if let name = json[PropertyKeys.PropertyName.rawValue].string{
        
        newUnit.apartmentName = name
    }
    
    if let coverPhoto = json[PropertyKeys.CoverPhoto.rawValue].dictionaryObject {
        
        for (_, url) in coverPhoto {
            
            if let photoURL = url as? String {
                newUnit.coverPhotoURL = photoURL
            }
        }
        
    }
    
    if let unitPrice = json[PropertyKeys.RentPrice.rawValue].string{
        newUnit.price = unitPrice
    }
    
    //need method for location
    
    if let petsAllowed = json[PropertyKeys.PetsAllowed.rawValue].bool {
        
        newUnit.petsAllowed = petsAllowed
        
    }
    
    
    if let washingMachineType = json[PropertyKeys.PetsAllowed.rawValue].string {
        
        newUnit.washingMachineType = washingMachineType
    }
    
    
    if let rentPrice = json[PropertyKeys.RentPrice.rawValue].string {
        
        newUnit.RentPrice = rentPrice
        
    }
    
    
    if let rentFrequency = json[PropertyKeys.RentFrequency.rawValue].string {
        
        newUnit.RentFrequency = rentFrequency
        
    }
    
    
    if let numberOfBedrooms = json[PropertyKeys.BedroomNumber.rawValue].string {
        
        newUnit.numberOfBedrooms = numberOfBedrooms
        
    }
    
    if let numberOfBathrooms = json[PropertyKeys.BathroomNumber.rawValue].string {
        
        newUnit.numberOfBathrooms = numberOfBathrooms
        
    }
    
    return newUnit
    
    
}


//for array of all units

struct ApartmentArray {
    var apartments = [Apartment]()
    
    
    init(dictionary: [String : Any]) {
        
        let json = JSON(dictionary)
        
        var arrayForReturn = [Apartment]()

        for (key, subJSon) in json {
            
            let newUnit = newApartmentType(key: key, json: subJSon)
            
//            var newUnit = Apartment.init()
//            newUnit.itemKey = key
//            
//           
//            if let name = subJSon[PropertyKeys.PropertyName.rawValue].string{
//                
//                newUnit.apartmentName = name
//            }
//            
//            if let coverPhoto = subJSon[PropertyKeys.CoverPhoto.rawValue].dictionaryObject {
//                
//                for (_, url) in coverPhoto {
//                    
//                    if let photoURL = url as? String {
//                        newUnit.coverPhotoURL = photoURL
//                    }
//                }
//           
//            }
//            
//            if let unitPrice = subJSon[PropertyKeys.RentPrice.rawValue].string{
//                newUnit.price = unitPrice
//            }
//            
//            //need method for location
//            
//            if let petsAllowed = subJSon[PropertyKeys.PetsAllowed.rawValue].bool {
//                
//                newUnit.petsAllowed = petsAllowed
//                
//            }
//            
//            
//            if let washingMachineType = subJSon[PropertyKeys.PetsAllowed.rawValue].string {
//                
//                newUnit.washingMachineType = washingMachineType
//            }
//            
//            
//            if let rentPrice = subJSon[PropertyKeys.RentPrice.rawValue].string {
//                
//                newUnit.RentPrice = rentPrice
//                
//            }
//            
//            
//            if let rentFrequency = subJSon[PropertyKeys.RentFrequency.rawValue].string {
//                
//                newUnit.RentFrequency = rentFrequency
//                
//            }
//            
//            
//            if let numberOfBedrooms = subJSon[PropertyKeys.BedroomNumber.rawValue].string {
//                
//                newUnit.numberOfBedrooms = numberOfBedrooms
//                
//            }
//            
//            if let numberOfBathrooms = subJSon[PropertyKeys.BathroomNumber.rawValue].string {
//                
//                newUnit.numberOfBathrooms = numberOfBathrooms
//                
//            }
            
            
            arrayForReturn.append(newUnit)
            
        }
        
        self.apartments = arrayForReturn
    }
}










//MARK: parse current favorites

struct ApartmentFavorites {
    
    var urlKey: String
    var propertyKey: String
    
}



struct CurrentApartmentFavorites {
    
    var currentFavoriets = [ApartmentFavorites]()
    
    init(dictionary: [String : Any]) {
        
        let json = JSON(dictionary)
        
        var arrayToReturn = [ApartmentFavorites]()
        
        for (key, subJSon) in json {
            
            if let propKey = subJSon[PropertyKeys.PropertyKey.rawValue].string {
                arrayToReturn.append(ApartmentFavorites(urlKey: key, propertyKey: propKey))
            }

        }
        
        self.currentFavoriets = arrayToReturn
        
    }
}














