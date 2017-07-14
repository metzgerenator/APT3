//
//  PropertyPhotosViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/12/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class PropertyPhotosViewController: UIViewController {
    
    
    var delegate: appendToDictionaryDelegate?
    
    
    var propertyPhotos = [PropertyPhoto]()
    
    
    let resuseIdentifier = "photoCell"
      
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        //delegate?.appender(key: .BathroomNumber, value: "25")
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


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









