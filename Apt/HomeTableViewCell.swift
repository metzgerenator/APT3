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
    
    var delegate: likeButtonDelegate?
    
    var currentUnit: Apartment?
    
    @IBOutlet var apartmentImage: UIImageView!
    
    @IBOutlet var apartmentPrice: UILabel!
 
    @IBOutlet var apartmentName: UILabel!
    
    @IBOutlet var apartmentLocation: UILabel!
    
    
    @IBOutlet var likeButtonOutlet: UIButton!
    
    @IBAction func apartmentLikeButton(_ sender: UIButton) {
        
        if let delagateCheck = delegate, let selectedUnit = currentUnit {
            
            delagateCheck.unitisLiked(unitLiked: true, unit: selectedUnit)
        }
        
        
        
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func changeButton(isFavorite: Bool) {
        
        if isFavorite {
            likeButtonOutlet.setImage(#imageLiteral(resourceName: "Heart - Full"), for: .normal)
        } else {
            likeButtonOutlet.setImage(#imageLiteral(resourceName: "Heart - Empty"), for: .normal)
        }
        
    }
    
    func configureCell(unit: Apartment) {
        
        currentUnit = unit
        
        if let price = unit.price {
            apartmentPrice.text = price
        }
        
        if let name = unit.apartmentName {
            apartmentName.text = name
            
        }
        
        if let location = unit.location {
            
            apartmentLocation.text = location.address
            
        } else {
            
            apartmentLocation.text = "no address"
        }
        
        
        if let imageURL = unit.coverPhotoURL {
            
            apartmentImage.clipsToBounds = true
            
            let url = URL(string: imageURL)
            let placeholderImage = #imageLiteral(resourceName: "test")
            
            apartmentImage.sd_setImage(with: url, placeholderImage: placeholderImage)
       
            
        } else {
            //add something letting them know no cover
            apartmentImage.image = #imageLiteral(resourceName: "test")
            
        }
        
        
        
    }
    
    
    
    //
    
    

}
