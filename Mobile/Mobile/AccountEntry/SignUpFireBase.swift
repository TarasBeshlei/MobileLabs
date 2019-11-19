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
    private var regularArr: [NSRegularExpression] = []
    private var textFiedlsList = [UITextField]()
    private var lablesList = [UILabel]()
    private var errorDict = [0: "Pleas, fill thies field.", 1: "Password is too weak.", 2: "Pleas, fill thies field. Count 10 of number requirements", 3: "Incorrect Email"]
    private var counterWhenValid = 0
    
    //MARK: UIButton Methods
    @IBAction func signUpButton(_ sender: Any) {
        allTextFieldsAreValid()
        if (counterWhenValid == 4) {
            signUpFirebase()
            counterWhenValid = 0
        }
        SignUpFireBase.nameCopy = nameField.text!
    }
    
    @IBAction func backToSignIn(_ sender: Any) {
        performSegue(withIdentifier: "backToSignIn", sender: self)
    }
    
    //MARK: View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        signInButton.layer.cornerRadius = 7
        fbSignOut.layer.cornerRadius = 7
        phoneField.delegate = self
        setupNSRegularExpression()
    }
    
    //MARK: Private Methods
    private func signUpFirebase() {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
            if (error == nil) {
                print("Success Up")
                self.performSegue(withIdentifier: "backToSignIn", sender: self)
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.nameField.text
                changeRequest?.commitChanges(completion: nil)
                guard let name = authResult?.user.displayName else {return}
                
                
            } else {
                self.signUpError()
            }
        }
    }
    
    private func signUpError() {
        Validation().validationIndication(inField: emailField)
        Validation().validationIndication(inField: passwordField)
        passwordErrorLable.text = "Email don't exist or this email already had been sign up"
    }
    
    private func validate(string: String, withRegex regex: NSRegularExpression) -> Bool {
        let range = NSRange(string.startIndex..., in: string)
        let matchRange = regex.rangeOfFirstMatch(in: string, options: .reportProgress, range: range)
        return matchRange.location != NSNotFound
    }
    
    private func setupNSRegularExpression() {
        textFiedlsList = [nameField, passwordField, phoneField, emailField]
        lablesList = [nameErrorLable, passwordErrorLable, phoneErrorLable, emailErrorLable]
        let patterns = ["^[a-z]{1,10}$","^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$", "^[0-9]{6,14}$","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"]
        regularArr = patterns.map {
            do {
                let reg = try NSRegularExpression(pattern: $0, options: .caseInsensitive)
                return reg
            } catch {
                #if targetEnvironment(simulator)
                fatalError("Error initializing regular expressions. Exiting.")
                #else
                return nil
                #endif
            }
        }
    }
    
    private func allTextFieldsAreValid() -> Bool {
        for (index, textFiedls) in textFiedlsList.enumerated() {
            let regex = regularArr[index]
            guard let text = textFiedls.text else {
                print("Fail")
                return false
            }
            var b = validate(string: text, withRegex: regex)
            if (b == false){
                if(errorDict.keys.contains(index)) {
                    lablesList[index].text = errorDict[index]
                    Validation().validationIndication(inField: textFiedlsList[index])
                    counterWhenValid = 0
                }
            } else {
                Validation().borderStandartColor(inField: textFiedlsList[index])
                lablesList[index].text = ""
                counterWhenValid += 1
            }
        }
        if (counterWhenValid == 4){
            return false
        } else {
            return true
        }
    }
}

//MARK: UITextFieldDelegate
extension SignUpFireBase: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharactersForPhoneField = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharactersForPhoneField.isSuperset(of: characterSet)
    }
}
