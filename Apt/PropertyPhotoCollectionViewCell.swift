//
//  PropertyPhotoCollectionViewCell.swift
//  Apt
//
//  Created by Michael Metzger  on 7/10/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class PropertyPhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var PropertyPhoto: UIImageView!
    
    
    @IBOutlet var addPropertyPhotoLabel: UILabel!
    
    
    
    func conFigureCell(image: String?) {
        
        PropertyPhoto.isHidden = true
        addPropertyPhotoLabel.isHidden = true
        
        if let inputImage = image {
            
            PropertyPhoto.isHidden = false
            PropertyPhoto.image = UIImage(contentsOfFile: inputImage)
            
        } else {
            addPropertyPhotoLabel.isHidden = false
            addPropertyPhotoLabel.text = "add photo"
            
            
        }
        
        
    }
    
    
    
}
