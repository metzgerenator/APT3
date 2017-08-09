//
//  FirbaseReadWrite.swift
//  Apt
//
//  Created by Michael Metzger  on 6/28/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth


var currentUSer: User?  {
    guard let user =  Auth.auth().currentUser else { return nil}
    return user
}

enum UserAuthType: String {
    case facebook
    case email
    
}


enum Childs: String {
    
    case Properties
    case Users
    case Authtype
    case Favorite_Properties
    //hack to fix 
    case clearCover
    
}

enum PropertyKeys: String {
    
    case RentPrice = "Rent_Price"
    case RentFrequency = "Rent_Frequency"
    case PropertyName = "Property_Name"
    case BedroomNumber = "Number_of_Bedrooms"
    case BathroomNumber = "Number_of_Bathrooms"
    case PetsAllowed = "Pets_Allowed"
    case WasherDryerType = "Washingmachine_Type"
    case PropertyPhotos = "Property_Photos"
    case CoverPhoto = "Cover_Photo"
    case PropertyKey = "Property_key"
    case Longitude = "Longitude"
    case Latitude = "Latitude"
    case Address = "Address"
    case UserLocation = "User_Location"
    case ExtraAmenities = "Extra_Amenities"

    
}

enum Endpoints {
    
    case users
    case currentUSerProperties
    case favoriteProperties
    
    var url: DatabaseReference {
        switch self {
            
        case .users:
            return  Database.database().reference().child(Childs.Users.rawValue)
            //be sure to add listener for user so nill collesing doesn't happen
        case .currentUSerProperties:
            return Database.database().reference().child(Childs.Users.rawValue).child("\(currentUSer?.uid ?? "")").child(Childs.Properties.rawValue)
            
        case .favoriteProperties:
            
            return Database.database().reference().child(Childs.Users.rawValue).child("\(currentUSer?.uid ?? "")").child(Childs.Favorite_Properties.rawValue)
    

        }
    }
    

    static func createNewUser(user: User, authType: UserAuthType) {
        
        let uid = user.uid
        
        
        self.users.url.child(uid).setValue([Childs.Authtype.rawValue : authType.rawValue])
        
        
        
    }
    
    
    static func appendToExisting(with reference: DatabaseReference, values: [String : Any]) {
        
        
        reference.setValue(values)
 
    }
    
    static func removeFromExisting(with reference: DatabaseReference) {
        
        reference.removeValue()
        
    }
    
    

    
    static func appendPropertyValues(_ values: [String : Any])-> DatabaseReference? {
        
        if let user = currentUSer {
            
            let autoID = self.users.url.child(user.uid).child(Childs.Properties.rawValue).childByAutoId()
            
          autoID.setValue(values)
         return autoID
            
        } else {
            
            return nil
        }
        
    }
    
    

    
}




















