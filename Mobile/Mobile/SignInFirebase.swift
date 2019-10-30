//
//  SighInFirebase.swift
//  Mobile
//
//  Created by Taras Beshley on 9/9/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin

final class SignInFirebase: UIViewController {
    
    //MARK: UI Variables
    @IBOutlet weak private var welcomeLable: UILabel!
    @IBOutlet weak private var fbButton: UIButton!
    @IBOutlet weak private var signOutButton: UIButton!
    
    //MARK: UIButton Methods
    @IBAction func Exit(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "signout", sender: nil)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        performSegue(withIdentifier: "signout", sender: nil)
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbButton.layer.cornerRadius = 7
        self.signOutButton.layer.cornerRadius = 7
        let currentUser = Auth.auth().currentUser?.displayName
        welcomeLable.text = "Welcome: \(currentUser!)"
        // Do any additional setup after loading the view.
    }
}
