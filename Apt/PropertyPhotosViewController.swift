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
    
    var propertyPhotosDictionary = [String : Any]()

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
        
        picker.allowsEditing = false
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "captionForImage" {
            
            guard let vc = segue.destination as? SubmitPhotoViewController, let image = sender as? UIImage else {return}
            
            vc.delegate = self
            
            vc.selectedImage = image
            
            
        }
        
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
    
    //captionForImage
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.performSegue(withIdentifier: "captionForImage", sender: image)
 
            
        } else {
            
            print("error ")
        }
        
        dismiss(animated: true, completion: nil)
        
        //transition to next vc here
    }
    
    
    
    
    
    
}



//MARK: protocols 

extension PropertyPhotosViewController: photoDictionaryCreateDelegate {
    
    func appendToPhotoDictinary(photo: PropertyPhoto) {
        
        let caption = photo.photoCaption
        let downloadPath = photo.downLoadPath
        
        propertyPhotosDictionary.updateValue(downloadPath, forKey: caption)
        
    }
    
}



















