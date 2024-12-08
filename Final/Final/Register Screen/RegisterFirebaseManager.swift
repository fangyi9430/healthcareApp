//
//  RegisterFirebaseManager.swift
//  Final
//
//  Created by Eva H on 11/22/24.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount() {
        // MARK: Display the progress indicator...
        showActivityIndicator()
        
        // MARK: Create a Firebase user with email and password...
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text {
            // Validations...
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    // MARK: There is an error creating the user...
                    print("Error creating user: \(error.localizedDescription)")
                    self.hideActivityIndicator()
                } else if let result = result {
                    // MARK: User creation is successful...
                    let uid = result.user.uid
                    self.setNameOfTheUserInFirebaseAuth(name: name, uid: uid, email: email)
                }
            }
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String, uid: String, email: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
            if let error = error {
                // MARK: There was an error updating the profile...
                print("Error updating profile: \(error.localizedDescription)")
                self.hideActivityIndicator()
            } else {
                // MARK: Profile update successful, save to Firestore
                self.saveUserToFirestore(uid: uid, name: name, email: email)
            }
        }
    }
    
    
    
    func saveUserToFirestore(uid: String, name: String, email: String) {
        let database = Firestore.firestore()
        let userCollection = database.collection("users")
        let userDocumentData: [String: Any] = [
            "userID": uid,
            "name": name,
            "email": email,
            "phone": "", // Default empty
            "dateOfBirth": "", // Default empty
            "height": "", // Default empty
            "weight": "", // Default empty
            "sex": "", // Default empty
            "profilePictureURL": "" // Default empty
        ]
        
        userCollection.document(uid).setData(userDocumentData) { error in
            // Hide the progress indicator
            self.hideActivityIndicator()
            
            if let error = error {
                print("Error adding user document to Firestore: \(error.localizedDescription)")
            } else {
                print("User document added successfully to Firestore with UID as document ID.")
                
                
                // Navigate back to the previous screen
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
