//
//  SignUpFireBase.swift
//  Mobile
//
//  Created by Taras Beshley on 9/16/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import Firebase

final class SignUpFireBase: UIViewController, UITextFieldDelegate {

    //MARK: UI Variables
    @IBOutlet weak private var emailField: UITextField!
    @IBOutlet weak private var passwordField: UITextField!
    @IBOutlet weak private var nameField: UITextField!
    @IBOutlet weak private var phoneField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!
    @IBOutlet weak private var errorInFieldField: UILabel!
    @IBOutlet weak private var emailErrorLable: UILabel!
    @IBOutlet weak private var passwordErrorLable: UILabel!
    @IBOutlet weak private var nameErrorLable: UILabel!
    @IBOutlet weak private var phoneErrorLable: UILabel!
    @IBOutlet weak private var fbSignOut: UIButton!
    
    //MARK: Static Variables
    public static var nameCopy :String! = nil
    
    //MARK: Public Variables
    private var slideDownCountEmail :Int = 0
    private var slideDownCountPassword :Int = 0
    private var slideDownCountName :Int = 0
    private var slideDownCountPhone :Int = 0
    private var validationAnimationCount : Int = 0
   
    //MARK: Button Methods
    @IBAction func signUpButton(_ sender: Any) {
   
        validationForEmail()
        validationForPassword()
        validationForName()
        validationForPhone()
        
        SignUpFireBase.nameCopy = nameField.text!
        
        if ((emailField.text!.isEmpty && passwordField.text!.isEmpty && nameField.text!.isEmpty && phoneField.text!.isEmpty) || (passwordField.text!.isEmpty && nameField.text!.isEmpty && phoneField.text!.isEmpty) || (nameField.text!.isEmpty && phoneField.text!.isEmpty) || (phoneField.text!.isEmpty)  && (emailField.text!.isEmpty) && (passwordField.text!.isEmpty) && (phoneField.text!.count != 10) && (passwordField.text!.count <= 8)) {
        } else {
            SignUpFireBase.nameCopy = ", \(nameField.text!)"
            signUpFirebase()
        }
    }
    
    @IBAction func backToSignIn(_ sender: Any) {
        performSegue(withIdentifier: "backToSignIn", sender: self)
    }
    
    //MARK: Private Methods
    private func signUpFirebase() {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
            if (error == nil) {
                print("Success Up")
                self.performSegue(withIdentifier: "WelcomeFromSignUp", sender: self)
                if (self.validationAnimationCount == 1) {
                    self.signUpErrorUp()
                    self.validationAnimationCount = 0
                }
            } else if (self.validationAnimationCount == 0) {
                self.signUpErrorDown()
                self.validationAnimationCount = 1
            }
        }
    }

    private func signUpErrorDown() {
        Validation().validationIndication(inField: emailField)
        Validation().validationIndication(inField: passwordField)
        Validation().fieldsSlideDown(inField: nameField)
        Validation().fieldsSlideDown(inField: phoneField)
        Validation().errorFieldMessageAnimateDown(inField: nameErrorLable)
        Validation().errorFieldMessageAnimateDown(inField: phoneErrorLable)
        passwordErrorLable.text! = "Email don't exist or this email already had been sign up"
    }
    
    private func signUpErrorUp() {
        Validation().borderStandartColor(inField: emailField)
        Validation().borderStandartColor(inField: passwordField)
        Validation().fieldsSlideUp(inField: nameField)
        Validation().fieldsSlideUp(inField: phoneField)
        Validation().errorFieldMessageAnimationUp(inField: nameErrorLable)
        Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
        passwordErrorLable.text! = "Email don't exist or this email already had been sign up"
    }
    
    private func validateEmptyField() {
        if (emailField.text! == "" && passwordField.text! == "" && nameField.text! == "" && phoneField.text! == "") {
            self.errorInFieldField.text! = "Please, Sign In or Sign Up."
        }
    }
    
    private func validationForEmail() {
        if (emailField.text! == "" && slideDownCountEmail == 0) {
            Validation().validationIndication(inField: emailField)
            Validation().fieldsSlideDown(inField: passwordField)
            Validation().fieldsSlideDown(inField: nameField)
            Validation().fieldsSlideDown(inField: phoneField)
            Validation().errorFieldMessageAnimateDown(inField: passwordErrorLable)
            Validation().errorFieldMessageAnimateDown(inField: nameErrorLable)
            Validation().errorFieldMessageAnimateDown(inField: phoneErrorLable)
            emailErrorLable.text! = "Pleas, fill thies field."
            slideDownCountEmail = 1
        } else if (emailField.text!.count > 0 && slideDownCountEmail == 1) {
            Validation().borderStandartColor(inField: emailField)
            Validation().fieldsSlideUp(inField: passwordField)
            Validation().fieldsSlideUp(inField: nameField)
            Validation().fieldsSlideUp(inField: phoneField)
            Validation().errorFieldMessageAnimationUp(inField: passwordErrorLable)
            Validation().errorFieldMessageAnimationUp(inField: nameErrorLable)
            Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
            emailErrorLable.text! = ""
            slideDownCountEmail -= 1
        }
    }
    
    private func validationForPassword() {
        if ((passwordField.text! == "" && slideDownCountPassword == 0) || (passwordField.text!.count < 8 && slideDownCountPassword == 0)) {
            Validation().validationIndication(inField: passwordField)
            Validation().fieldsSlideDown(inField: nameField)
            Validation().fieldsSlideDown(inField: phoneField)
            Validation().errorFieldMessageAnimateDown(inField: nameErrorLable)
            Validation().errorFieldMessageAnimateDown(inField: phoneErrorLable)
            passwordErrorLable.text! = "Password is required more than 8 character"
            slideDownCountPassword = 1
        } else if (passwordField.text!.count >= 8 && slideDownCountPassword == 1) {
            Validation().borderStandartColor(inField: passwordField)
            Validation().fieldsSlideUp(inField: nameField)
            Validation().fieldsSlideUp(inField: phoneField)
            Validation().errorFieldMessageAnimationUp(inField: nameErrorLable)
            Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
            passwordErrorLable.text! = ""
            slideDownCountPassword -= 1
        }
    }
    
    private func validationForName() {
        if (nameField.text! == "" && slideDownCountName == 0) {
            Validation().validationIndication(inField: nameField)
            Validation().fieldsSlideDown(inField: phoneField)
            Validation().errorFieldMessageAnimateDown(inField: phoneErrorLable)
            nameErrorLable.text! = "Please, fill this field."
            slideDownCountName = 1
        } else if (nameField.text!.count > 0 && slideDownCountName == 1) {
            Validation().borderStandartColor(inField: nameField)
            Validation().fieldsSlideUp(inField: phoneField)
            Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
            slideDownCountName -= 1
            nameErrorLable.text! = ""
        }
    }
    
    private func validationForPhone() {
        if ((phoneField.text! == "" && slideDownCountPhone == 0) || (phoneField.text!.count != 10)) {
            Validation().validationIndication(inField: phoneField)
            slideDownCountPhone = 1
            phoneErrorLable.text! = "Pleas, fill thies field. Count 10 of number requirements"
        } else if (phoneField.text!.count > 0 && slideDownCountPhone == 1 && phoneField.text!.count >= 10) {
            Validation().borderStandartColor(inField: phoneField)
            slideDownCountPhone -= 1
            phoneErrorLable.text! = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharactersForPhoneField = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharactersForPhoneField.isSuperset(of: characterSet)
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        self.signInButton.layer.cornerRadius = 7
        self.fbSignOut.layer.cornerRadius = 7
        phoneField.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
