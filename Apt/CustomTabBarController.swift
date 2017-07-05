//
//  CustomTabBarController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBar: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupMiddleButton()
        
    }
    
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.blue
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(named: "example"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        self.tabBar.barTintColor = UIColor.white
        view.layoutIfNeeded()
    }
    
    
    
    // MARK: - Actions
    
    @objc private func menuButtonAction(sender: UIButton) {
        
        self.performSegue(withIdentifier: "addProperty", sender: nil)
    }

    
}




class customNavItem: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
       self.navigationController?.navigationBar.backgroundColor =  #colorLiteral(red: 0.1155018732, green: 0.505417347, blue: 0.9707024693, alpha: 1)
        
    }
    

    
    
    
   
}
