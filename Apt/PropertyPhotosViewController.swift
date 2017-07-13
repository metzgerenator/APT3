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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension PropertyPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
}









