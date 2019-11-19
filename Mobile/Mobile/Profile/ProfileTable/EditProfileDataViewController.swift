//
//  EditProfileDataViewController.swift
//  Mobile
//
//  Created by Taras Beshley on 11/16/19.
//  Copyright © 2019 Taras Beshley. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

final class EditProfileDataViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var profileUploadImage: UIImageView!
    @IBOutlet private weak var changeNameField: UITextField!
    @IBOutlet private weak var changeEmailField: UITextField!
    
    //MARK: Private Variables
    private var image: UIImage? = nil
    private var validationRef = Validation()
    
    //MARK:  View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        profileUploadImage.image = UIImage(named: "no-image")
        setProfileIamge()
    }
    
    //MARK: IBAction
    @IBAction private func editButton(_ sender: Any) {
        editProfile()
        uploadProfileImage()
    }
    
    //MARK: Private Methods
    private func setProfileIamge() {
        profileUploadImage.clipsToBounds = true
        profileUploadImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profileUploadImage.addGestureRecognizer(tapGesture)
    }
    
    private func uploadProfileImage() {
        guard let imageSelected = self.image else { return }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }
        guard let user = Auth.auth().currentUser else { return }
        let storageRef = Storage.storage().reference(forURL: "gs://mobile-5bfd5.appspot.com")
        let storageProfileRef = storageRef.child("profile").child(user.uid)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        storageProfileRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            self.showAlert()
        }
    }
    
    @objc private func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    private func editProfile() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        guard let updateEmailRef = Auth.auth().currentUser else { return }
        if (!changeNameField.text!.isEmpty) {
            changeRequest?.displayName = changeNameField.text
            changeRequest?.commitChanges(completion: nil)
            showAlert()
        }
        if (!changeEmailField.text!.isEmpty) {
            updateEmailRef.updateEmail(to: changeEmailField.text!) { (error) in
                if (error != nil) {
                    self.validationRef.validationIndication(inField: self.changeEmailField)
                } else {
                    self.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Edited", message: "Edited.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditProfileDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileUploadImage.image = imageSelected
            image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileUploadImage.image = imageOriginal
            image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
