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



protocol photoDictionaryCreateDelegate {
    
    func appendToPhotoDictinary(photo: PropertyPhoto)
    
}




protocol likeButtonDelegate {
    func unitisLiked (unitLiked: Bool, unit: Apartment)
}


protocol ClearPhotoDictionaryDelegate {
    func clearDitionary(key: String)
}


protocol addToCustomAmenitiesDelegate {
    func addAmenity(with amenity: String, for cell: UITableViewCell)
}



protocol extraAmenitiesDelegate {
    
    func updatedExtraAmenities(array: [String])
}

protocol extraAmenitiesTableViewHeightDeelegate {
    func updateHeight(newHeight: Int)
}













