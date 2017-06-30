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




enum UserAuthType: String {
    case facebook
    case email
    
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
    
    
}









//create user 




