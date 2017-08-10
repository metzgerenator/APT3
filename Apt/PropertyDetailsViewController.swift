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
    
    @IBOutlet var heightForImageView: NSLayoutConstraint!
    
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        
        childDelegate?.remoteSegue()
        
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
                
                childDelegate = vc
                
                vc.loadCoverPhotDelegate = self
                vc.adjustParentHeadHeightDelegate = self
                vc.animateParentHeight = self
                
                
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

extension PropertyDetailsViewController: loadCoverPhotoProtocol, adJustParentHeaderHeight, scrollViewResetAndAnimateHeight {
    
 
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
    
    
    
    func headerHeightAdjust(cgFloat: CGFloat, add: Bool) {
        
        if add {
            backgroundImageView.isHidden = false
            heightForImageView.constant += cgFloat
            
        } else {
            if cgFloat == 65 {
                heightForImageView.constant = 65
                backgroundImageView.isHidden = true
                
            } else{
                backgroundImageView.isHidden = false
                heightForImageView.constant -= cgFloat
            }
            
        }
        
        
    }
    
    
    func hideAnimation() {
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    func animateHeader() {
        
        heightForImageView.constant = 137
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    
}






























