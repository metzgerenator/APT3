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
    
    
    
    @IBOutlet var faceBookButton: FBSDKLoginButton!
    
    @IBAction func userNameEnter(_ sender: UITextField) {
        
        pasWord.becomeFirstResponder()
        
    }
    
    
    
    @IBAction func passWordEnter(_ sender: UITextField) {
        createUSer()
    }
    
    
    
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        
        createUSer()

     
    }
    
    

    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //faceBookButton.delegate = self
       // let button = FBSDKLoginButton()
//        button.center = self.view.center
//        self.view.addSubview(button)
        
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
extension NewUserViewController: FBSDKLoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
        if error == nil {
            
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            print("success facebook\(credential) ")
            
            
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    
                    print("error occured \(error)")
                    // ...
                    return
                }
                
                print("user = (user)")
                // User is signed in
                // ...
            }
        

        }
        
        if let error = error {
            print("error facebook")
            print(error.localizedDescription)
            return
        }
        // ...
    }
    
    
    
    
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








