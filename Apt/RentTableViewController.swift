//
//  RentTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/5/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class RentTableViewController: UITableViewController {
    
    
    
    var delegate: appendToDictionaryDelegate?
    
    let pickerWheel = ["Weekly", "Yearly", "Monthly"]
    
    var currentPrice: String?
    var rentTerms:String?
    
    var textTimer: Timer?
    
    
    @IBOutlet var priceField: UITextField!
    
    @IBOutlet var frequencyOutlet: UILabel!
    

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        //be sure to zero out what is appended to delage 
        
        self.dismiss(animated: true, completion: nil)
 
    }
    
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if let delegateCheck = delegate {
            
            if let rent = currentPrice {
                
                 delegateCheck.appender(key: .RentPrice, value: rent)
            }
            
            if let terms = rentTerms {
                
                delegateCheck.appender(key: .RentFrequency, value: terms)
            }
        
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func priceChangeEdit(_ sender: UITextField) {
        
        
        textTimer?.invalidate()
        textTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(currencyFormat), userInfo: nil, repeats: false)
        
        
     
    }
    
    
    
    func currencyFormat() {
        
        
        guard let textIn = priceField.text?.digitsOnly, let double = Int(textIn) else {return}
        
        let nsnumberDouble = NSNumber(value: double)
        
        let currencyFormat = NumberFormatter.localizedString(from: nsnumberDouble , number: .currency)
        
        priceField.text = currencyFormat
        currentPrice = currencyFormat
        
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
        
       rentTerms = pickerWheel[row]
        
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







