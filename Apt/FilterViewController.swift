//
//  FilterViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 8/28/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        
    }
    
    
    @IBOutlet var lowToHighOutlet: UISwitch!
    
    
    
    @IBAction func lowtoHighAction(_ sender: UISwitch) {
 
            highToLowOutlet.isOn = !sender.isOn

        
    }
    
    
    @IBOutlet var highToLowOutlet: UISwitch!
    
    
    @IBAction func highToLowAction(_ sender: UISwitch) {
        lowToHighOutlet.isOn = !sender.isOn
    }
    
    
    
    @IBOutlet var byListOutlit: UISwitch!
    
    
    
    @IBAction func byListAction(_ sender: UISwitch) {
        
        
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
