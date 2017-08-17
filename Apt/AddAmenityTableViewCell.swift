//
//  AddAmenityTableViewCell.swift
//  Apt
//
//  Created by Michael Metzger  on 8/9/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class AddAmenityTableViewCell: UITableViewCell {
    
    
    var delegate: addToCustomAmenitiesDelegate?
    
     var textTimer: Timer?
    
    
    
    @IBOutlet var newAmenity: UILabel!
    
    @IBOutlet var addAmenityButton: UIButton!
    
    
  
    
    //don't forget to add to delegate
    func editAmenity() {
        
        delegate?.addAmenity(for: self)
 
    }
    
    @IBAction func addAmenityAction(_ sender: UIButton) {
        
        editAmenity()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(text: String)  {
        
        newAmenity.text = text
        
    }
    
    
    func hideTextField(isHidden: Bool) {
        
        if !isHidden {
            newAmenity.isHidden = true
            
        } else {
            newAmenity.isHidden = false
            
        }
        
        addAmenityButton.isHidden = isHidden
        
    }

}
