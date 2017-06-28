//
//  NewUserViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 6/28/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewUserViewController: UIViewController {
    
    
    @IBOutlet var userName: UITextField!
    
    @IBOutlet var pasWord: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
//        Auth.auth().createUser(withEmail: , password: <#T##String#>) { (user, error) in
//            
//        }
        
     
    }
    
    
    @IBAction func loginWithFacebook(_ sender: UIButton) {
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.clearRound()

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
