//
//  RentTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class RentTableViewController: UITableViewController {
    
    
    let pickerWheel = ["Weekly", "Yearly", "Monthly"]
    
    
    @IBOutlet var priceField: UITextField!
    
    @IBOutlet var frequencyOutlet: UILabel!
    

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
 
    }
    
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        // add protocol here
        
    }
    
    
    
    @IBAction func priceChangeEdit(_ sender: UITextField) {

        guard let textIn = sender.text?.digitsOnly, let double = Int(textIn) else {return}
        
        let nsnumberDouble = NSNumber(value: double)
        
       let currencyFormat = NumberFormatter.localizedString(from: nsnumberDouble , number: .currency)
        
        priceField.text = currencyFormat
        
        ///print("here is currency format \(currencyFormat)")
        
        
    }
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//MARK: picker data source

extension RentTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerWheel.count
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        frequencyOutlet.text = pickerWheel[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerWheel[row]
    }
    
    


}


extension String {
    var digitsOnly: String {
         return components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
    }
}







