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
    
    
    var childDelegate: remoteSegue?
    
    var refernceFromHomeView: String?

    @IBOutlet var backgroundImageView: UIView!
    
    @IBOutlet var mainBackGroundImage: UIImageView!

    @IBOutlet var CameraButtonOutlet: UIButton!
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        
        childDelegate?.remoteSegue()
        
    }
    
    var propertyName: String?
    

    override func viewDidLoad() {
        
        //rentPrice
        
        print("herer is reference key \(String(describing: refernceFromHomeView))")
    
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
                
                childDelegate = vc
                
                vc.loadCoverPhotDelegate = self
                
                
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

extension PropertyDetailsViewController: loadCoverPhotoProtocol {
    
 
    func loadPhoto(image: String) {

        if image == Childs.clearCover.rawValue {
            
            mainBackGroundImage.image = nil
            
        } else {
            
            let url = URL(string: image)
            let placeholderImage = #imageLiteral(resourceName: "test")
            //cellLabel.text = propertyPhoto.photoCaption
            
            mainBackGroundImage.sd_setImage(with: url, placeholderImage: placeholderImage)
            
        }
        
        
 
        
    }
    
    
}






























