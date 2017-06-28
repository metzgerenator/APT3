//
//  UibuttonFormats.swift
//  Apt
//
//  Created by Michael Metzger  on 6/28/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
    func standardRoundWithFill()  {
        self.layer.cornerRadius = 10.0
        self.backgroundColor = #colorLiteral(red: 0.1155018732, green: 0.505417347, blue: 0.9707024693, alpha: 1)
        self.setTitleColor(.white, for: .normal)
        
    }
    
    
    func clearRound() {
        
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.1155018732, green: 0.505417347, blue: 0.9707024693, alpha: 1).cgColor
    }
    
    
}

