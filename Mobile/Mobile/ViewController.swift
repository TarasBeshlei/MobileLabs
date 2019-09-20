//
//  ViewController.swift
//  Mobile
//
//  Created by Taras Beshley on 9/5/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {
   
    var fbLoginSuccess = false
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var errorInField: UILabel!
    @IBOutlet weak var fbButton: UIButton!
    
    
    @IBAction func enterButton(_ sender: Any) {
        
            signInFirebase()
            validateField()
            validateField()
        
    }
    
    
    
    @IBAction func signInFacebook(_ sender: Any) {
        
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case . cancelled:
                print("User cancelled")
                break
            case .failed(let error):
                print("error login")
                break
            case .success(let grantedPermissions, let declinedPermissions, let accesToken):
                print("Success")
                self.performSegue(withIdentifier: "WelcomeSegue", sender: nil)
                self.fbLoginSuccess = true
            }
        }
        
    }
    
    func signInFirebase() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if (error == nil) {
                print("Success in")
                self!.performSegue(withIdentifier: "WelcomeSegue", sender: self)
            } else {
                if (self?.email.text! != "" && self?.password.text! != "") {
                    self?.errorInField.text! = "Wrong email or password, try againg."
                }
            }
        }
    }
   
    func validateField() {
        
        if (email.text! == "" || password.text! == "") {
            validationIndication()
            self.errorInField.text! = "Please, Sign In or Sign Up."
        }
        
    }
    
    func validationIndication() {
        
        email.layer.borderColor = UIColor.red.cgColor
        email.layer.borderWidth = 1.0
        email.layer.cornerRadius = 3
        password.layer.borderColor = UIColor.red.cgColor
        password.layer.borderWidth = 1.0
        password.layer.cornerRadius = 3
        
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.email.center.x += 10
            self.password.center.x += 10
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.email.center.x -= 20
            self.password.center.x -= 20
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.email.center.x += 10
            self.password.center.x += 10
        }, completion: nil)
    }
    

//
//    func googleSignButtonUI() {
//        let gSignIn = GIDSignInButton(frame: CGRect(x: 55, y: 520, width: 270, height: 50))
//        gSignIn.layer.cornerRadius = 10
//        view.addSubview(gSignIn)
//        self.button.layer.cornerRadius = 7
//
//    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.button.layer.cornerRadius = 7
        self.fbButton.layer.cornerRadius = 7
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (fbLoginSuccess == true)
        {
            
            performSegue(withIdentifier: "WelcomeSegue", sender: self)
    
        }
    }
}
