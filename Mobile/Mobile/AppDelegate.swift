//
//  AppDelegate.swift
//  Mobile
//
//  Created by Taras Beshley on 9/5/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        return true
    }
}

