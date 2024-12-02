//
//  EditProfileViewController.swift
//  Final
//
//  Created by 李方一 on 12/1/24.
//

import UIKit
import FirebaseFirestore
import PhotosUI
import FirebaseStorage

class EditProfileViewController: UIViewController {
    
    let editProfileView = EditProfileView()
    
    let storage = Storage.storage()
    
    var user: User?
    
    var pickedImage:UIImage?
    
    var currentUserID: String?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Edit Profile"
        
        guard let user = user else {
            print("Error: No user data passed to EditProfileViewController")
            return
        }
        
        editProfileView.nameLabel.text = "Name: \(user.name)"
        editProfileView.emailLabel.text = "Email: \(user.email)"
        
        editProfileView.buttonTakePhoto.menu = getMenuImagePicker()
        print(editProfileView.buttonTakePhoto.showsMenuAsPrimaryAction) // 确保输出为 true
        print(editProfileView.buttonTakePhoto.menu ?? "fail")
        //editProfileView.buttonTakePhoto.addTarget(self, action: #selector(debugButtonTapped), for: .touchUpInside)

    }
    @objc func debugButtonTapped() {
        print("Button tapped")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func updateView(with user: User) {
        editProfileView.nameLabel.text = "Name: \(user.name)"
        editProfileView.emailLabel.text = "Email: \(user.email)"
    }
    
    @objc private func onSaveButtonTapped() {
        
    
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    func getMenuImagePicker() -> UIMenu{
        print(" call to getMenuImagePicker() successed.")
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    
    func pickUsingCamera(){
        
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    
    
    

}


extension EditProfileViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.editProfileView.buttonTakePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}


extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editProfileView.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
