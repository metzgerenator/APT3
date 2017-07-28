//
//  PropertyPhotoCollectionViewCell.swift
//  Apt
//
//  Created by Michael Metzger  on 7/10/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage



class PropertyPhotoCollectionViewCell: UICollectionViewCell {
    
 
    @IBOutlet var cellImage: UIImageView!
    
    @IBOutlet var checkedImageView: UIImageView!
    
    @IBOutlet var cellLabel: UILabel!
    
    
    var image: UIImage?
    
    var label: String?
    
    
    override func prepareForReuse() {
        
        image = nil
        label = nil
  
    }
    
    var editing: Bool = false {
        
        didSet {
            cellLabel.isHidden = editing
            checkedImageView.isHidden = !editing
        }
        
        
    }
    
    override var isSelected: Bool {
        
        didSet {
            
            if editing {
                
                checkedImageView.image = UIImage(named: isSelected ? "Checked" : "Unchecked")
            }
            
        }
        
        
    }
    
    
    
    
    
    
    func setupCell(propertyPhoto: PropertyPhoto ) {
        cellImage.isHidden = false
        cellLabel.textColor = .white
        let url = URL(string: propertyPhoto.downLoadPath)
        let placeholderImage = #imageLiteral(resourceName: "test")
        cellLabel.text = propertyPhoto.photoCaption
        
        cellImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        
        cellImage.setShowActivityIndicator(true)
        cellImage.setIndicatorStyle(.gray)

    }
}
