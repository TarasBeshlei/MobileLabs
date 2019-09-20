//
//  SignUpFireBase.swift
//  Mobile
//
//  Created by Taras Beshley on 9/16/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import Firebase

class SignUpFireBase: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorInField: UILabel!
    @IBOutlet weak var emailErro: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var fbSignOut: UIButton!
    
    static var nameCopy :String! = nil
    var slideDownCountEmail :Int! = 0
    var slideDownCountPassword :Int! = 0
    var slideDownCountName :Int! = 0
    var slideDownCountPhone :Int! = 0
    var signUpCount : Int! = 0
   
    @IBAction func signUpButton(_ sender: Any) {
   
        validationForEmail()
        validationForPassword()
        validationForName()
        validationForPhone()
        
        SignUpFireBase.nameCopy = name.text!
        
        if ((email.text! != "" && password.text! != "" && name.text! != "" && phone.text! != "") || (password.text! != "" && name.text! != "" && phone.text! != "") || (name.text! != "" && phone.text! != "") || (phone.text! != "")  && (email.text! != "") && (password.text! != "")) {
        
            SignUpFireBase.nameCopy = ", \(name.text!)"
            
            signUpFirebase()
            
        }
    }
    
    @IBAction func backToSignIn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "backToSignIn", sender: self)
        
    }
    
    func signUpFirebase() {
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            if (error == nil) {
                print("Success Up")
                self.performSegue(withIdentifier: "WelcomeFromSignUp", sender: self)
                if (self.signUpCount == 1) {
                    
                    self.signUpErrorUp()
                    self.signUpCount = 0
                    
                }
            } else if (self.signUpCount == 0) {
                
                self.signUpErrorDown()
                self.signUpCount = 1
                
            }
        }
    }

    func signUpErrorDown() {
        
        
        Validation().validationIndication(inField: email)
        Validation().validationIndication(inField: password)
        Validation().fieldsSlideDown(inField: name)
        Validation().fieldsSlideDown(inField: phone)
        Validation().errorFieldMessageAnimateDown(inField: nameError)
        Validation().errorFieldMessageAnimateDown(inField: phoneError)
        passwordError.text! = "Email don't exist or this email already had been sign up"
        
    }
    
    func signUpErrorUp() {
        
        Validation().borderStandartColor(inField: email)
        Validation().borderStandartColor(inField: password)
        Validation().fieldsSlideUp(inField: name)
        Validation().fieldsSlideUp(inField: phone)
        Validation().errorFieldMessageAnimationUp(inField: nameError)
        Validation().errorFieldMessageAnimationUp(inField: phoneError)
        passwordError.text! = "Email don't exist or this email already had been sign up"
        
    }
    
    func validateEmptyField() {
        
        if (email.text! == "" && password.text! == "" && name.text! == "" && phone.text! == "") {
            
            self.errorInField.text! = "Please, Sign In or Sign Up."
        }
    }
    
    func validationForEmail() {
        
        if (email.text! == "" && slideDownCountEmail == 0) {
            
            Validation().validationIndication(inField: email)
            Validation().fieldsSlideDown(inField: password)
            Validation().fieldsSlideDown(inField: name)
            Validation().fieldsSlideDown(inField: phone)
            Validation().errorFieldMessageAnimateDown(inField: passwordError)
            Validation().errorFieldMessageAnimateDown(inField: nameError)
            Validation().errorFieldMessageAnimateDown(inField: phoneError)
            emailErro.text! = "Pleas, fill thies field."
            slideDownCountEmail = 1
            
        } else if (email.text!.count > 0 && slideDownCountEmail == 1) {
            
            Validation().borderStandartColor(inField: email)
            Validation().fieldsSlideUp(inField: password)
            Validation().fieldsSlideUp(inField: name)
            Validation().fieldsSlideUp(inField: phone)
            Validation().errorFieldMessageAnimationUp(inField: passwordError)
            Validation().errorFieldMessageAnimationUp(inField: nameError)
            Validation().errorFieldMessageAnimationUp(inField: phoneError)
            emailErro.text! = ""
            
            slideDownCountEmail -= 1
            
        }
    }
    
    func validationForPassword() {
        
        if ((password.text! == "" && slideDownCountPassword == 0) || (password.text!.count < 8 && slideDownCountPassword == 0)) {
            
            Validation().validationIndication(inField: password)
            Validation().fieldsSlideDown(inField: name)
            Validation().fieldsSlideDown(inField: phone)
            Validation().errorFieldMessageAnimateDown(inField: nameError)
            Validation().errorFieldMessageAnimateDown(inField: phoneError)
            
            passwordError.text! = "Password is required more than 8 character"
            slideDownCountPassword = 1
            
        } else if (password.text!.count >= 8 && slideDownCountPassword == 1) {
            
            Validation().borderStandartColor(inField: password)
            Validation().fieldsSlideUp(inField: name)
            Validation().fieldsSlideUp(inField: phone)
            Validation().errorFieldMessageAnimationUp(inField: nameError)
            Validation().errorFieldMessageAnimationUp(inField: phoneError)
            
            passwordError.text! = ""
            slideDownCountPassword -= 1
            
        }
    }
    
    func validationForName() {
        
        if (name.text! == "" && slideDownCountName == 0) {
            
            Validation().validationIndication(inField: name)
            Validation().fieldsSlideDown(inField: phone)
            Validation().errorFieldMessageAnimateDown(inField: phoneError)
            nameError.text! = "Please, fill this field."
            
            slideDownCountName = 1
            
        } else if (name.text!.count > 0 && slideDownCountName == 1) {
            
            Validation().borderStandartColor(inField: name)
            Validation().fieldsSlideUp(inField: phone)
            Validation().errorFieldMessageAnimationUp(inField: phoneError)
            slideDownCountName -= 1
            nameError.text! = ""
            
        }
    }
    
    func validationForPhone() {
        
        if (phone.text! == "" && slideDownCountPhone == 0 && phone.text!.count < 10 && phone.text!.count > 10) {
            
            Validation().validationIndication(inField: phone)
            slideDownCountPhone = 1
            phoneError.text! = "Pleas, fill thies field. Count 10 of number requirements"
            
        } else if (phone.text!.count > 0 && slideDownCountPhone == 1 && phone.text!.count >= 10) {
            
            Validation().borderStandartColor(inField: phone)
            slideDownCountPhone -= 1
            phoneError.text! = ""
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        self.signInButton.layer.cornerRadius = 7
        self.fbSignOut.layer.cornerRadius = 7
        self.phone.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}
