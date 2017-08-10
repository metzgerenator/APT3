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
    func loadPhoto(image: String)
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

protocol insertNewCellDelegate {
    
    func insertCell()
    
}

protocol extraAmenitiesDelegate {
    
    func updatedExtraAmenities(array: [String])
}

protocol extraAmenitiesTableViewHeightDeelegate {
    func updateHeight(newHeight: Int)
}


protocol adJustParentHeaderHeight {
    
    func headerHeightAdjust(cgFloat: CGFloat, add: Bool)
    
}

protocol scrollViewResetAndAnimateHeight {
    func animateHeader()
}










