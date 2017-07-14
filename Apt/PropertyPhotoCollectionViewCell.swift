//
//  PropertyPhotoCollectionViewCell.swift
//  Apt
//
//  Created by Michael Metzger  on 7/10/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class PropertyPhotoCollectionViewCell: UICollectionViewCell {
    
 
    @IBOutlet var cellImage: UIImageView!
    
    
    @IBOutlet var cellLabel: UILabel!
    
    
    var image: UIImage?
    
    var label: String? {
        
        didSet {
            if let newLabel = label {
                
                cellLabel.text = newLabel
            }
        }
        
    }
    
    
}
