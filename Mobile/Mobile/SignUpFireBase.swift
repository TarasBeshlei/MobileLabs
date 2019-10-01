//
//  SignUpFireBase.swift
//  Mobile
//
//  Created by Taras Beshley on 9/16/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import Firebase

final class SignUpFireBase: UIViewController {
    
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
    
    //MARK: Private Variables
    private var validationAnimationCount : Int = 0
    private var valCount : Int = 0
    private var noValidatedFieldsList: [Int: UITextField] = [:]
    private var validatedFieldsList: [Int: UITextField] = [:]
    private var textFiedlsList = [UITextField?]()
    private var lablesList = [UILabel]()
    private var errorDict = [0: "Pleas, fill thies field.", 1: "Password is required more than 8 character", 2: "Please, fill this field.", 3: "Pleas, fill thies field. Count 10 of number requirements"]
    private var checkedFieldsIndex = [Int]()
    private var sortedKeysNoValid  = [Int]()
    private var sortedKeysValid = [Int]()
    var list1: [Int] = []
    var list2: [Int] = []
    var pss = [5]
    var countOfAnimationsDown = 0
    var countOfAnimationsUp = 1
    
    //MARK: Button Methods
    @IBAction func signUpButton(_ sender: Any) {
//        validationForEmail()
//        validationForPassword()
//        validationForName()
//        validationForPhone()

        valid()
        
        
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
        passwordErrorLable.text = "Email don't exist or this email already had been sign up"
    }
    
    private func signUpErrorUp() {
        Validation().borderStandartColor(inField: emailField)
        Validation().borderStandartColor(inField: passwordField)
        Validation().fieldsSlideUp(inField: nameField)
        Validation().fieldsSlideUp(inField: phoneField)
        Validation().errorFieldMessageAnimationUp(inField: nameErrorLable)
        Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
        passwordErrorLable.text = "Email don't exist or this email already had been sign up"
    }
    
    private func validateEmptyField() {
        if (emailField.text?.isEmpty ?? false && passwordField.text?.isEmpty ?? false && nameField.text?.isEmpty ?? false && phoneField.text?.isEmpty ?? false) {
            errorInFieldField.text = "Please, Sign In or Sign Up."
        }
    }
    
    private func noValidatedFields() {
        noValidatedFieldsList = [:]
        validatedFieldsList = [:]
        
        if (emailField.text?.isEmpty ?? false) {
            noValidatedFieldsList[0] = emailField
        } else if (emailField.text!.count > 0) {
            validatedFieldsList[0] = emailField
        }
        
        if ((passwordField.text?.isEmpty ?? false) || (passwordField.text!.count < 8)) {
            noValidatedFieldsList[1] = passwordField
        } else if (passwordField.text!.count >= 8) {
            validatedFieldsList[1] = passwordField
        }
        
        if (nameField.text?.isEmpty ?? false) {
            noValidatedFieldsList[2] = nameField
            
        } else if (nameField.text!.count > 0) {
            validatedFieldsList[2] = nameField
            
        }
        
        if ((phoneField.text?.isEmpty ?? false) || (phoneField.text?.count != 10)) {
            noValidatedFieldsList[3] = phoneField
        } else if (phoneField.text!.count > 0 && phoneField.text!.count >= 10) {
            validatedFieldsList[3] = phoneField
        }
        
    }
    
    private func valid() {
        
        noValidatedFields()
        textFiedlsList = [emailField, passwordField, nameField, phoneField]
        lablesList = [emailErrorLable, passwordErrorLable, nameErrorLable, phoneErrorLable]
        sortedKeysNoValid = noValidatedFieldsList.keys.sorted()
        sortedKeysValid = validatedFieldsList.keys.sorted()
      
        var listfornoval: [Int] = []
        var listforval: [Int] = []

        listforval = []
        listfornoval = []
        
        for i in sortedKeysNoValid {
        
            if (list1.contains(i)) {
                listforval.append(i)
            } else if (list1.contains(i) == false){
                
            }
        }
        
        for i in sortedKeysNoValid {
            
            
            if (listforval.contains(i)) {
                
            } else {
                listfornoval.append(i)
            }
            
        }
        
        print(listforval)
        print(listfornoval)
        if (list1.isEmpty) {
            listfornoval = [0, 1, 2, 3]
        }
        
        
        list1 = []
   
            for i in sortedKeysNoValid {
                
                
                Validation().validationIndication(inField: noValidatedFieldsList[i]!)
                lablesList[i].text = errorDict[i]
                
                if (i != 3) {
                    for j in (i + 1)...3 {
                        
                        Validation().fieldsSlideDown(inField: textFiedlsList[j]!)
                        Validation().errorFieldMessageAnimateDown(inField: lablesList[j])
                    
                    }
                    
                }
                list1.append(i)
            }
        
    
        
        
            for i in sortedKeysValid {

                self.lablesList[i].isHidden = true

                if (i != 3) {
                    for j in (i + 1)...3 {
                        Validation().borderStandartColor(inField: textFiedlsList[j]!)
                        Validation().fieldsSlideUp(inField: textFiedlsList[j]!)
                        Validation().errorFieldMessageAnimationUp(inField: lablesList[j])

                    }

                }
            }
        }

    
//
//    private func validationForEmail() {
//        if (emailField.text?.isEmpty ?? false && slideDownCountEmail == 0) {
//            Validation().validationIndication(inField: emailField)
//            Validation().fieldsSlideDown(inField: passwordField)
//            Validation().fieldsSlideDown(inField: nameField)
//            Validation().fieldsSlideDown(inField: phoneField)
//            Validation().errorFieldMessageAnimateDown(inField: passwordErrorLable)
//            Validation().errorFieldMessageAnimateDown(inField: nameErrorLable)
//            Validation().errorFieldMessageAnimateDown(inField: phoneErrorLable)
//            emailErrorLable.text! = "Pleas, fill thies field."
//            slideDownCountEmail = 1
//        } else if (emailField.text!.count > 0 && slideDownCountEmail == 1) {
//            Validation().borderStandartColor(inField: emailField)
//            Validation().fieldsSlideUp(inField: passwordField)
//            Validation().fieldsSlideUp(inField: nameField)
//            Validation().fieldsSlideUp(inField: phoneField)
//            Validation().errorFieldMessageAnimationUp(inField: passwordErrorLable)
//            Validation().errorFieldMessageAnimationUp(inField: nameErrorLable)
//            Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
//            emailErrorLable.text = ""
//            slideDownCountEmail -= 1
//        }
//    }
//
//    private func validationForPassword() {
//        if ((passwordField.text?.isEmpty ?? false && slideDownCountPassword == 0) || (passwordField.text!.count < 8 && slideDownCountPassword == 0)) {
//            Validation().validationIndication(inField: passwordField)
//            Validation().fieldsSlideDown(inField: nameField)
//            Validation().fieldsSlideDown(inField: phoneField)
//            Validation().errorFieldMessageAnimateDown(inField: nameErrorLable)
//            Validation().errorFieldMessageAnimateDown(inField: phoneErrorLable)
//            passwordErrorLable.text = "Password is required more than 8 character"
//            slideDownCountPassword = 1
//        } else if (passwordField.text!.count >= 8 && slideDownCountPassword == 1) {
//            Validation().borderStandartColor(inField: passwordField)
//            Validation().fieldsSlideUp(inField: nameField)
//            Validation().fieldsSlideUp(inField: phoneField)
//            Validation().errorFieldMessageAnimationUp(inField: nameErrorLable)
//            Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
//            passwordErrorLable.text = ""
//            slideDownCountPassword -= 1
//        }
//    }
//
//    private func validationForName() {
//        if (nameField.text?.isEmpty ?? false && slideDownCountName == 0) {
//            Validation().validationIndication(inField: nameField)
//            Validation().fieldsSlideDown(inField: phoneField)
//            Validation().errorFieldMessageAnimateDown(inField: phoneErrorLable)
//            nameErrorLable.text = "Please, fill this field."
//            slideDownCountName = 1
//        } else if (nameField.text!.count > 0 && slideDownCountName == 1) {
//            Validation().borderStandartColor(inField: nameField)
//            Validation().fieldsSlideUp(inField: phoneField)
//            Validation().errorFieldMessageAnimationUp(inField: phoneErrorLable)
//            slideDownCountName -= 1
//            nameErrorLable.text = ""
//        }
//    }
//
//    private func validationForPhone() {
//        if ((phoneField.text?.isEmpty ?? false && slideDownCountPhone == 0) || (phoneField.text?.count != 10)) {
//            Validation().validationIndication(inField: phoneField)
//            slideDownCountPhone = 1
//            phoneErrorLable.text = "Pleas, fill thies field. Count 10 of number requirements"
//        } else if (phoneField.text!.count > 0 && slideDownCountPhone == 1 && phoneField.text!.count >= 10) {
//            Validation().borderStandartColor(inField: phoneField)
//            slideDownCountPhone -= 1
//            phoneErrorLable.text = ""
//        }
//    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        self.signInButton.layer.cornerRadius = 7
        self.fbSignOut.layer.cornerRadius = 7
        phoneField.delegate = self
    }
}

extension SignUpFireBase: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharactersForPhoneField = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharactersForPhoneField.isSuperset(of: characterSet)
    }
}
