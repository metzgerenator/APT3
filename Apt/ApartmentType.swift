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
    var isFavorite: Bool?
    
    
   
 
    
}

struct ApartmentArray {
    var apartments = [Apartment]()
    
    
    init(dictionary: [String : Any]) {
        
        let json = JSON(dictionary)
        
        var arrayForReturn = [Apartment]()

        for (key, subJSon) in json {
            
            var newUnit = Apartment.init()
            newUnit.itemKey = key
            
           
            if let name = subJSon[PropertyKeys.PropertyName.rawValue].string{
                
                newUnit.apartmentName = name
            }
            
            if let coverPhoto = subJSon[PropertyKeys.CoverPhoto.rawValue].dictionaryObject {
                
                for (_, url) in coverPhoto {
                    
                    if let photoURL = url as? String {
                        newUnit.coverPhotoURL = photoURL
                    }
                }
           
            }
            
            if let unitPrice = subJSon[PropertyKeys.RentPrice.rawValue].string{
                newUnit.price = unitPrice
            }
            
            arrayForReturn.append(newUnit)
            
        }
        
        self.apartments = arrayForReturn
    }
}





