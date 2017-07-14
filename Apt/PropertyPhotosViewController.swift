//
//  PropertyPhotosViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/12/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import Firebase


class PropertyPhotosViewController: UIViewController {
    
    
    let storage = Storage.storage()
    
    var delegate: appendToDictionaryDelegate?
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var propertyPhotos = [PropertyPhoto]()

    let resuseIdentifier = "photoCell"
    
    let picker = UIImagePickerController()
      
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.isHidden = true
       
        picker.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

//MARK: collection cell methods

extension PropertyPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier, for: indexPath)
        
        if let photoCell = cell as? PropertyPhotoCollectionViewCell {
            
            photoCell.label = "Test"
            
            return photoCell
        }
        
        return cell
        
        
    }
    
    
    
}


//MARK: imagePicker Controlls 


extension PropertyPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
            
            guard let data = UIImageJPEGRepresentation(image, 0.9) else {return}
            
             let storageRef = storage.reference().child("propertyImages").child("test.jpg")
            
            storageRef.putData(data, metadata: nil, completion: { (metaData, error) in
                
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                
                if let error = error {
                    
                    print("error occured error\(error)")
                } else {
                    
                    let downloadURL = metaData!.downloadURL()
                    print("here is the file path \(String(describing: downloadURL))")
                    
                }
                
            })
            
            
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
        //transition to next vc here
    }
    
    
    
}























