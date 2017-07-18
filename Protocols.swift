//
//  Protocols.swift
//  Apt
//
//  Created by Michael Metzger  on 7/6/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import UIKit

protocol appendToDictionaryDelegate {
    func appender(key: PropertyKeys, value: Any)
}


protocol remoteSegue {
    func remoteSegue()
    
}

protocol photoDictionaryCreateDelegate {
    
    func appendToPhotoDictinary(photo: PropertyPhoto)
    
}

protocol loadCoverPhotoProtocol {
    func loadPhoto(image: UIImage)
}




