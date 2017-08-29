//
//  FilterViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 8/28/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var filterDelegate: FilterCurrentView?
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        filterMainView()
        
        self.dismiss(animated: true, completion: nil)
        
        
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}


//MARK: Convience Methods

extension FilterViewController {
    
    
    func filterMainView() {
        
        let filter = Filter(highToLow: highToLowOutlet.isOn, lowToHigh: lowToHighOutlet.isOn, sortByList: byListOutlit.isOn)
        filterDelegate?.filterHomeView(CurrentFilter: filter)
        
    }

}





