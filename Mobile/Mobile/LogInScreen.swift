//
//  ViewController.swift
//  Mobile
//
//  Created by Taras Beshley on 9/5/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin

final class LogInScreen: UIViewController {
    
    private var fbLoginSuccess = false
    
    //MARK: UI Variables
    @IBOutlet weak private var email: UITextField!
    @IBOutlet weak private var password: UITextField!
    @IBOutlet weak private var button: UIButton!
    @IBOutlet weak private var errorInField: UILabel!
    @IBOutlet weak private var fbButton: UIButton!
    
    //MARK: Button Methods
    @IBAction func signInButton(_ sender: Any) {
        signInFirebase()
        validateField()
    }
    
    @IBAction func signInFacebookButton(_ sender: Any) {
        signInFacebook()
    }
    
    //MARK: Private Methods
    private func validationIndication() {
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
    
    private func signInFirebase() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if (error == nil) {
                print("Success in")
                self!.performSegue(withIdentifier: "WelcomeSegue", sender: self)
            } else {
                if (self!.email.text!.isEmpty && self!.password.text!.isEmpty) {
                    self?.errorInField.text! = "Wrong email or password, try againg."
                    self?.validationIndication()
                }
            }
        }
    }
    
    private func signInFacebook() {
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
    
    private func validateField() {
        if (email.text!.isEmpty || password.text!.isEmpty) {
            validationIndication()
            self.errorInField.text! = "Please, Sign In or Sign Up."
        }
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.button.layer.cornerRadius = 7
        self.fbButton.layer.cornerRadius = 7
    }
    
    override func viewDidAppear(_ animated: Bool) {
            guard fbLoginSuccess == true else {return}
            performSegue(withIdentifier: "WelcomeSegue", sender: self)
    }
}
