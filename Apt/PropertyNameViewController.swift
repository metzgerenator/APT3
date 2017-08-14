//
//  PropertyNameViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class PropertyNameViewController: UIViewController {
    
    

    @IBOutlet var propertyName: UITextField!
    
    
    @IBAction func propertyNameDone(_ sender: Any) {
        
        guard let name = propertyName.text else { return }
        
        if name.characters.count > 0 {
      
            
            self.performSegue(withIdentifier: "property_details", sender: name)
            
            
        } else {
            self.standardAlert(title: "Fill in Fields", message: "Please fill in Property Name ")
        }
        
     
        
    }
    
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "property_details" {
            
            guard let vc = segue.destination as? PropertyDetailsTableViewController,
                let propertyName = sender as? String  else {return}
            
            vc.appender(key: .PropertyName, value: propertyName)
            vc.unitName = propertyName
           // vc.apartmentNameOutlet.text = propertyName
            
            
        }
    }

  

}








