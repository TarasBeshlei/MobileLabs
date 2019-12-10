//
//  ProfileController.swift
//  Mobile
//
//  Created by Taras Beshley on 11/16/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SDWebImage

final class ProfileController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet private weak var profileTable: UITableView!

    
    //MARK:  View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        profileTable.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        profileTable.reloadData()
    }
    
    //MARK: Private Methods
    private func setUpTableView() {
        profileTable.delegate = self
        profileTable.dataSource = self
        profileTable.rowHeight = UITableView.automaticDimension
    }
    
}

//MARK: UITableViewDelegate
extension ProfileController: UITableViewDelegate {}

//MARK: UITableViewDataSource
extension ProfileController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell") as! ProfileCell
        let storageRef = Storage.storage().reference(forURL: "gs://mobile-5bfd5.appspot.com")
        let storageProfileRef = storageRef.child("profile").child(userInfo.userId)
        storageProfileRef.downloadURL { (url, error) in
            if let metaImageUrl = url {
                cell.profileImage.sd_setImage(with: metaImageUrl, placeholderImage: nil)
            } else {
                cell.profileImage.image = UIImage(named: "no-image")
            }
        }
        
        cell.profileEmail.text = userInfo.userEmail
        cell.profileName.text = userInfo.userName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProfileEdit", sender: self)
    }
}
