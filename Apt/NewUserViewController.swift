//
//  NewUserViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 6/28/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class NewUserViewController: UIViewController {
    
    
    @IBOutlet var userName: UITextField!
    
    @IBOutlet var pasWord: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func userNameEnter(_ sender: UITextField) {
        
        pasWord.becomeFirstResponder()
        
    }
    
    
    
    @IBAction func passWordEnter(_ sender: UITextField) {
        createUSer()
    }
    
    
    
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        
        createUSer()

     
    }
    
    
    @IBAction func loginWithFacebook(_ sender: UIButton) {
        
        
        
        
        
        
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//        loginButton.center = self.view.center;
//        [self.view addSubview:loginButton];
//        
        
        let button = FBSDKLoginButton()
        button.center = self.view.center
        self.view.addSubview(button)
        
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


//MARK: create user
extension NewUserViewController {
    
    func createUSer() {
        
        guard let username = userName.text, let password = pasWord.text else { return }
        
        
        if username.characters.count > 0 && password.characters.count > 0 {
            
            Auth.auth().createUser(withEmail: username  , password: password) { (user, error) in
                
                if error == nil {
                    print("success")
                    
                } else {
                    
                    self.standardAlert(title: "Credential Error", message: (error?.localizedDescription)!)
                }
                
                
                
                
            }
            
        } else {
            
            self.standardAlert(title: "Credentials", message: "Please fill in all fields")
            
            
        }
        
        
    }
    
    
}






