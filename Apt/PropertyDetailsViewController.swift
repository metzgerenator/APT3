//
//  PropertyDetailsViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class PropertyDetailsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!

    var propertyName: String?
    

    override func viewDidLoad() {
        //rentPrice
    
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
                
                vc.appender(key: .PropertyName, value: name)
            }
            
            
        }
    }
    

  

}


extension PropertyDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    
    
    
    
}



























