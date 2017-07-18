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


struct ObServedPhotos {
    
    var photos: [PropertyPhoto]?
    
    
    init(dictionary: [String : Any]) {
        
       let json = JSON(dictionary)
        
        guard let photos = json[PropertyKeys.PropertyPhotos.rawValue].dictionaryObject else {return}
        
        var returnArray = [PropertyPhoto]()
        for (caption, url) in photos {
            
            if let photoURL = url as? String {
                let propertyPhoto = PropertyPhoto(photoCaption: caption, isCoverPhoto: false, downLoadPath: photoURL)
                returnArray.append(propertyPhoto)
            }

            
        }
        
        self.photos = returnArray
        
        
    }

}
