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
        validateField()
    }
    
    @IBAction func signInFacebookButton(_ sender: Any) {
        signInFacebook()
    }
    
    //MARK: View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        button.layer.cornerRadius = 7
        fbButton.layer.cornerRadius = 7
    }
    
    override func viewDidAppear(_ animated: Bool) {
            guard fbLoginSuccess == true else {return}
            performSegue(withIdentifier: "WaterListSegue", sender: self)
    }
    
    //MARK: Private Methods
    private func validationIndication() {
        Validation().validationIndication(inField: email)
        Validation().validationIndication(inField: password)
    }
    
    private func signInFirebase() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if (error == nil) {
                print("Success in")
                
                self!.performSegue(withIdentifier: "WaterListSegue", sender: self)
            } else {
                self?.errorInField.text! = "Wrong email or password, try againg."
                self?.validationIndication()
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
                self.performSegue(withIdentifier: "WaterListSegue", sender: nil)
                self.fbLoginSuccess = true
            }
        }
    }
    
    private func validateField() {
        if (email.text!.isEmpty || password.text!.isEmpty) {
            validationIndication()
            self.errorInField.text! = "Please, Sign In or Sign Up."
        } else {
            signInFirebase()
        }
    }
}
