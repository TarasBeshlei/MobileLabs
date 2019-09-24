//
//  SighInFirebase.swift
//  Mobile
//
//  Created by Taras Beshley on 9/9/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class SignInFirebase: UIViewController {
    
    //MARK: UI Variables
    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    var nameCop = SignUpFireBase.nameCopy
  
    //MARK: Button Methods
    @IBAction func Exit(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func button(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signout", sender: nil)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
                self.performSegue(withIdentifier: "signout", sender: nil)
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbButton.layer.cornerRadius = 7
        self.signOutButton.layer.cornerRadius = 7
        if (SignUpFireBase.nameCopy != nil) {
            welcome.text! = "Welcome\(nameCop!)"
        } else {
            welcome.text! = "Welcome"
        }
        // Do any additional setup after loading the view.
    }
}
