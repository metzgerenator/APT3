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
    
}

enum PropertyKeys: String {
    
    case RentPrice = "Rent_Price"
    case RentFrequency = "Rent_Frequency"
    case PropertyName = "Property_Name"
    case BedroomNumber = "Number_of_Bedrooms"
    case BathroomNumber = "Number_of_Bathrooms"
    case PetsAllowed = "Pets_Allowed"
    case WasherDryerType = "Washingmachine_Type"
    
}

enum Endpoints {
    
    case users
    
    var url: DatabaseReference {
        switch self {
            
        case .users:
            return  Database.database().reference().child("Users")

        }
    }
    

    static func createNewUser(user: User, authType: UserAuthType) {
        
        let uid = user.uid
        
        self.users.url.child(uid).setValue(["Authtype" : authType.rawValue])
        
        
        
    }
    
    
    static func appendToExisting(with reference: DatabaseReference, values: [String : Any]) {
        
        reference.setValue(values)
 
    }
    
    static func appendValues(_ values: [String : Any])-> DatabaseReference? {
        
        if let user = currentUSer {
            let autoID = self.users.url.child(user.uid).child("Properties").childByAutoId()
            
          autoID.setValue(values)
         return autoID
            
        } else {
            
            return nil
        }
        
    }
    
    
}









//create user 




