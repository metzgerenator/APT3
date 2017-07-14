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
    
    
    @IBOutlet var currentImage: UIImageView!
    
    
    @IBAction func submitPhoto(_ sender: UIBarButtonItem) {
        
        
        if let caption = currentCaption {
            
            guard let image = selectedImage, let data = UIImageJPEGRepresentation(image, 0.9) else {return}

            let storageRef = storage.reference().child("propertyImages").child("test.jpg")
            
            storageRef.putData(data, metadata: nil, completion: { (metaData, error) in
     
                if let error = error {
                    
                    print("error occured error\(error)")
                } else {
                    
                    let downloadURL = "\(metaData!.downloadURL()!)"
                    print("here is the file path \(String(describing: downloadURL))")
 
                     self.delegate?.appendToPhotoDictinary(photo: PropertyPhoto(photoCaption: caption, isCoverPhoto: self.coverSwitch.isOn, downLoadPath: downloadURL))
                    
                }
                
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

        currentCaption = sender.text

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
