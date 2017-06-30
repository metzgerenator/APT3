//
//  LoginViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 6/28/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet var signIn: UIButton!
    
    
    @IBOutlet var signUP: UIButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: sign user out
        try! Auth.auth().signOut()
        
      formattButtons()
        

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

//MARK: formatting
extension LoginViewController {
    
    func formattButtons() {
        signIn.standardRoundWithFill()
        signUP.standardRoundWithFill()
        
    }
    
    
}






