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
    
    var textToSend: String?
    
    
    @IBOutlet var newAmenity: UILabel!
    
    @IBOutlet var addAmenityButton: UIButton!
    
    
  
    
    //don't forget to add to delegate
    func editAmenity() {
        if let textCheck = textToSend {
            delegate?.addAmenity(with:textCheck, for: self)
        } else {
            delegate?.addAmenity(with: "dicks", for: self)
            
        }
        
        
        
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
