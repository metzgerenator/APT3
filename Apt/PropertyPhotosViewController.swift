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
    
    var propertyReference: DatabaseReference?
    
    var propertyPhotosDictionary = [String : Any]()

    var delegate: appendToDictionaryDelegate?
    
    let camerActionText = "add photo"
    
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var propertyPhotos = [PropertyPhoto]()

    let resuseIdentifier = "photoCell"
    
    let picker = UIImagePickerController()
    
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
         self.dismiss(animated: true, completion: nil)
        
    }
      
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        //need to delete photos somehow that are not already added
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    
        
    }
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let width = collectionView.frame.width / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    
        
        //download photos here
        
        loadingIndicator.isHidden = true
       
        picker.delegate = self
        
        
        if let url = propertyReference {
            
            url.observe(.value, with: { (snapshot) in
                
                let valueDictionary = snapshot.value as? [String : Any] ?? [:]
                
                
                 let photoURLS = ObServedPhotos.init(dictionary: valueDictionary)
                
                if let photoArray = photoURLS.photos {
                    self.propertyPhotos = photoArray
            
                    for photoOBject in photoArray {
                        
                        self.propertyPhotosDictionary.updateValue(photoOBject.downLoadPath, forKey: photoOBject.photoCaption)
                        
                    }
                }
                
                
                self.addCameraButton()
        
  
            })
            
            
        }

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
    
    
    func addCameraButton() {
        
        
        let cameraAction = PropertyPhoto.init(photoCaption: self.camerActionText, isCoverPhoto: false, downLoadPath: "")
        let lastIndex = self.propertyPhotos.count
        self.propertyPhotos.insert(cameraAction, at: lastIndex)
        self.collectionView.reloadData()
        
        
    }



}

//MARK: collection cell methods

extension PropertyPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return propertyPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier, for: indexPath)
        
        if let photoCell = cell as? PropertyPhotoCollectionViewCell {
            
            let currentPhoto = propertyPhotos[indexPath.row]
            
            if currentPhoto.photoCaption == camerActionText {
                photoCell.cameraAction()
           
            } else {
                
                photoCell.setupCell(propertyPhoto: currentPhoto)
            }
            
            
            
            return photoCell
        }
        
        return cell
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = propertyPhotos[indexPath.row]
        
        if photo.photoCaption == camerActionText {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
     
        
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
        
    }
    
    
    
    
    
    
}



//MARK: protocols 

extension PropertyPhotosViewController: photoDictionaryCreateDelegate {
    
    func appendToPhotoDictinary(photo: PropertyPhoto) {
        
        let caption = photo.photoCaption
        let downloadPath = photo.downLoadPath
     
        propertyPhotosDictionary.updateValue(downloadPath, forKey: caption)
        
        delegate?.appender(key: .PropertyPhotos, value: propertyPhotosDictionary)
        
        if photo.isCoverPhoto {
            
            let coverPhotoDic = [caption : downloadPath]
            
            delegate?.appender(key: .CoverPhoto, value: coverPhotoDic)
            
            
        }
        
        
    }
    
}



















