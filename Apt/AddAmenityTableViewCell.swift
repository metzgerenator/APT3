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
    
    
    @IBOutlet var newAmenityTextField: UITextField!
    
    @IBOutlet var addAmenityButton: UIButton!
    
    
    @IBAction func amenityTextDidChange(_ sender: UITextField) {
        
        print("started change")
        
        delegate?.addAmenity(with: "poo", for: self)
    
        // add nstimer
        
    }
    
    @IBAction func addAmenityAction(_ sender: UIButton) {
        
        
        delegate?.addAmenity(with: "poo", for: self)
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func hideTextField() {
        
        newAmenityTextField.isHidden = true
        
    }

}
