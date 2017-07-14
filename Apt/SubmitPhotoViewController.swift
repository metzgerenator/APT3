//
//  SubmitPhotoViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/14/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class SubmitPhotoViewController: UIViewController {
    
    var selectedImage: UIImage?
    
    
    @IBOutlet var currentImage: UIImageView!
    
    
    @IBAction func submitPhoto(_ sender: UIBarButtonItem) {
        
        
        
    }
    
    
    
    @IBOutlet var captionField: UITextField!
    
    
    
    @IBOutlet var coverSwitch: UISwitch!
    
    
    @IBAction func coverSwitchAction(_ sender: UISwitch) {
        
        
    }
    
    
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        
        view.endEditing(true)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
