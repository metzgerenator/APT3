//
//  HomeTableViewCell.swift
//  Apt
//
//  Created by Michael Metzger  on 7/19/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet var apartmentImage: UIImageView!
    
    @IBOutlet var apartmentPrice: UILabel!
 
    @IBOutlet var apartmentName: UILabel!
    
    @IBOutlet var apartmentLocation: UILabel!
    
    
    
    @IBAction func apartmentLikeButton(_ sender: UIButton) {
        
        
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(unit: Apartment) {
        
        if let price = unit.price {
            apartmentPrice.text = price
        }
        
        if let name = unit.apartmentName {
            apartmentName.text = name
            
        }
        
        
        if let imageURL = unit.coverPhotoURL {
            
            apartmentImage.clipsToBounds = true
            
            let url = URL(string: imageURL)
            let placeholderImage = #imageLiteral(resourceName: "test")
            
            apartmentImage.sd_setImage(with: url, placeholderImage: placeholderImage)
       
            
        }
        
        //add location
        
        
    }
    

}
