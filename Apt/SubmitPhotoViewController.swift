//
//  SubmitPhotoViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/14/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import  Firebase

class SubmitPhotoViewController: UIViewController {
    
    var selectedImage: UIImage?
    
    var currentCaption: String?
    
    var delegate: photoDictionaryCreateDelegate?
    
    let storage = Storage.storage()
    
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet var currentImage: UIImageView!
    
    
    @IBAction func submitPhoto(_ sender: UIBarButtonItem) {
        
        
        if let caption = currentCaption {
            
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
            
            guard let image = selectedImage, let data = UIImageJPEGRepresentation(image, 0.4) else {return}

            let storageRef = storage.reference().child("propertyImages").child("\(caption).jpg")
            
            
            
         let photoUpload = storageRef.putData(data, metadata: nil, completion: { (metaData, error) in
            
                
                
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
     
                if let error = error {
                    
                    self.standardAlert(title: "error", message: error.localizedDescription)
                    
                } else {
                    
                    let downloadURL = "\(metaData!.downloadURL()!)"
 
                     self.delegate?.appendToPhotoDictinary(photo: PropertyPhoto(photoCaption: caption, isCoverPhoto: self.coverSwitch.isOn, downLoadPath: downloadURL))
                    
                    self.navigationController?.popViewController(animated: true)
                
                }
                
            })
            
            photoUpload.observe(.progress, handler: { (snapshot) in
                let currentProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                
                print("here is the progress \(currentProgress)")
            })
            
        } else {
            
            self.standardAlert(title: "Caption", message: "Please add a Caption")
        }
        
        
    
        
      
        
    }
    
    
    
    @IBOutlet var captionField: UITextField!
    
    
    
    @IBOutlet var coverSwitch: UISwitch!
    
    
    @IBAction func coverSwitchAction(_ sender: UISwitch) {
        
        coverSwitch.isOn = sender.isOn
        
    }
    
    
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        
        view.endEditing(true)
        
    }
    
    
    @IBAction func editingDone(_ sender: UITextField) {
        
        let set = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ").inverted
   
        let stringToReturn = sender.text?.rangeOfCharacter(from: set)
        if stringToReturn != nil {
            
            self.standardAlert(title: "Only Text Please", message: "Please avoid using characters such as . and ' ")
        }
        
        
        currentCaption = sender.text

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadingIndicator.isHidden = true
        
        if let image = selectedImage {
            
            currentImage.image = image
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
