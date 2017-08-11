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
    var insertCellDelegate: insertNewCellDelegate?
    
     var textTimer: Timer?
    
    var textToSend: String?
    
    
    @IBOutlet var newAmenityTextField: UITextField!
    
    @IBOutlet var addAmenityButton: UIButton!
    
    
    @IBAction func amenityTextDidChange(_ sender: UITextField) {
        
        textToSend = sender.text
        textTimer?.invalidate()
        textTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(editAmenity), userInfo: nil, repeats: false)
        
        
       

        
    }
    
    
    func editAmenity() {
        if let textCheck = textToSend {
            delegate?.addAmenity(with:textCheck, for: self)
        }
        
        
        
    }
    
    @IBAction func addAmenityAction(_ sender: UIButton) {
        
        insertCellDelegate?.insertCell()
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(text: String)  {
        
        newAmenityTextField.text = text
        
    }
    
    
    func hideTextField(isHidden: Bool) {
        
        newAmenityTextField.isHidden = isHidden
        
    }

}