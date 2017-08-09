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
    
    
    @IBOutlet var newAmenityTextField: UITextField!
    
    @IBOutlet var addAmenityButton: UIButton!
    
    
    @IBAction func amenityTextDidChange(_ sender: UITextField) {
        
        
        delegate?.addAmenity(with: sender.text!, for: self)
    
        
        
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
