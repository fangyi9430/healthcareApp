
import Foundation
import FirebaseAuth
import FirebaseStorage

extension EditProfileViewController{
    func uploadProfilePhotoToStorage(){
        
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage{
            if let jpegData = image.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                profilePhotoURL = url
                                self.setPhotoOfTheUserInFirebaseAuth(photoURL: profilePhotoURL)
                                self.updateUserProfileData(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }else{
            updateUserProfileData(photoURL: profilePhotoURL)
        }
    }
    
    func updateUserProfileData(photoURL: URL?){
        
        var updatedData: [String: Any] = [
            "phone":editProfileView.phoneTextField.text ?? user?.phone ?? "",
            "sex": editProfileView.sexTextField.text ?? user?.sex ?? "",
            "dateOfBirth": editProfileView.dobTextField.text ?? user?.dateOfBirth ?? "",
            "weight": editProfileView.weightTextField.text ?? user?.weight ?? "",
            "height": editProfileView.heightTextField.text ?? user?.height ?? ""
        ]
        
        if let photoURL = photoURL {
            updatedData["profilePictureURL"] = photoURL.absoluteString
        }
        
        database.collection("users").document(currentUserID!).updateData(updatedData) { error in
            
            if let error = error {
                print("Failed to update user data: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: "Failed to save your profile. Please try again.")
            } else {
                print("User data successfully updated.")
                self.showAlert(title: "Success", message: "Your profile has been updated.")
            }
        }
    }
    
    func setPhotoOfTheUserInFirebaseAuth(photoURL: URL?){
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.photoURL = photoURL
            
            print("\(photoURL)")
            changeRequest?.commitChanges(completion: {(error) in
                if error != nil{
                    print("Error occured: \(String(describing: error))")
                }else{
                    //self.navigationController?.popViewController(animated: true)
                }
            })
        }
    
}

