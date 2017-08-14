//
//  PropertyDetailsViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import SDWebImage

class PropertyDetailsViewController: UIViewController {
    
    
    
    var refernceFromHomeView: String?

    @IBOutlet var backgroundImageView: UIView!
    
    @IBOutlet var mainBackGroundImage: UIImageView!

    @IBOutlet var CameraButtonOutlet: UIButton!
    
    @IBOutlet var heightForImageView: NSLayoutConstraint!
    
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        
        
    }
    
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    var propertyName: String?
    

    override func viewDidLoad() {
 
    
        super.viewDidLoad()
        self.navigationController?.title = "ADD DETAILS"
        
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        
        if segue.identifier == "embeded" {
            
            if let vc = segue.destination as? PropertyDetailsTableViewController, let name = propertyName {
                
        
                
                
                // Create a data referenc if this is coming from the home view
                
                if let refernceKey = refernceFromHomeView {
                    vc.propertyID = Endpoints.currentUSerProperties.url.child(refernceKey)
                    vc.listenOnceForCurrentValues()
                    
                } else {
                   vc.appender(key: .PropertyName, value: name)
                }
                
                
                
            }
            
            
        }
    }
    

  

}































