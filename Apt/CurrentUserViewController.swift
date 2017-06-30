//
//  CurrentUserViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 6/30/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit


class CurrentUserViewController: UIViewController {
    
    var propertyView = "properties"
    
    @IBOutlet var userName: UITextField!
    
    
    @IBOutlet var passWord: UITextField!
    
    
    @IBOutlet var loginButton: UIButton!
    
    
    @IBOutlet var faceBookLogin: FBSDKLoginButton!
    
  
    @IBAction func userNameNext(_ sender: UITextField) {
        
        passWord.becomeFirstResponder()
    }
    
    
    @IBAction func passwordGo(_ sender: UITextField) {
        
         authCurrentUSer()
    }
    
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        authCurrentUSer()

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
    



}


extension CurrentUserViewController: FBSDKLoginButtonDelegate {
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
        
        if error == nil {
            
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    
                    self.standardAlert(title: "Error", message: error.localizedDescription)
                    
                    // ...
                    return
                } else {
                    
                    
                    self.performSegue(withIdentifier: self.propertyView, sender: self)
                    
                }
                
                
            }
            
            
        }

        
        
        
        
    }
    
    
    
    //MARK: email authentication 
    
    
    func authCurrentUSer() {
        
         guard let username = userName.text, let password = passWord.text else { return }
        
        
         if username.characters.count > 0 && password.characters.count > 0 {
            
            Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
                
                if error == nil {
                    
                    self.performSegue(withIdentifier: self.propertyView, sender: self)
                    
                } else {
                    
                    
                    self.standardAlert(title: "Credential Error", message: (error?.localizedDescription)!)
                    
                }
                
            }
            
            
         } else {
            
            self.standardAlert(title: "Fill in Credentials", message: "Please fill out all fields")
            
        }
        
    }
    
    
    
    
    
    
    
}







