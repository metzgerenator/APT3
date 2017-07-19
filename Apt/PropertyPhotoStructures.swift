//
//  PropertyPhotoStructures.swift
//  Apt
//
//  Created by Michael Metzger  on 7/14/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import SwiftyJSON



struct PropertyPhoto {
    
    var photoCaption: String
    var isCoverPhoto: Bool
    var downLoadPath: String
    
}


class ObServedPhotos {
    
    var photos: [PropertyPhoto]?
    var coverPhotoURL: String?
    var coverPhotoCaption: String?

    init(dictionary: [String : Any]) {
        
        let json = JSON(dictionary)
        print("here is json \(json)")
        
        if let photos = json[PropertyKeys.PropertyPhotos.rawValue].dictionaryObject {
            var returnArray = [PropertyPhoto]()
            for (caption, url) in photos {
                
                if let photoURL = url as? String {
                    let propertyPhoto = PropertyPhoto(photoCaption: caption, isCoverPhoto: false, downLoadPath: photoURL)
                    returnArray.append(propertyPhoto)
                }
                
                
                if let propetyCover = url as? Dictionary<String, Any> {
                    
                    for (caption, url) in propetyCover {
                        print("here is caption \(caption),  here is url \(url)")
                        
                        if let photoURL = url as? String {
                            
                            self.coverPhotoCaption = caption
                            self.coverPhotoURL = photoURL
                        }
                        
                        
                        
                    }
                }
                
            }
            
            
            self.photos = returnArray
            
        }

 
        
    }
    
 
    
}





