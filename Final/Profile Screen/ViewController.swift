//
//  ViewController.swift
//  App12
//
//  Created by Sakib Miazi on 6/1/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    private let profileScreen = MainScreenView()
    
    var pickedImage:UIImage?
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    private var cachedUser: User?
    
    private let database = Firestore.firestore()
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
        if user == nil{
            //MARK: not signed in...
            self.currentUser = nil
            self.setupRightBarButton(isLoggedin: false)
            self.profileScreen.setLoggedOutState() // set state as logged in
            
        }else{
            //MARK: the user is signed in...
            self.currentUser = user
            if let uid = self.currentUser?.uid {
                self.setupRightBarButton(isLoggedin: true)
                self.profileScreen.setLoggedInState() // set state as logged in.
                self.loadUserData(for: uid)
            } else {
                print("Error: User ID is nil")
            }
            
        }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileScreen.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshProfileScreen(_:)),
            name: Notification.Name(NotificationNames.userDidUpdateProfile),
            object: nil
        )
    }
    
    @objc private func refreshProfileScreen(_ notification: Notification) {
        guard let userId = notification.userInfo?["userID"] as? String else {
            print("Error: User ID not found in notification")
            return
        }
        loadUserData(for: userId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func loadUserData(for userId: String) {
        database.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Failed to load user data: \(error.localizedDescription)")
                return
            }
            
            guard let data = snapshot?.data() else {
                print("No data found for document with userId: \(userId)")
                return
            }
            
            print("Fetched Firestore data: \(data)")
            
            // Ensure all fields have default values to avoid decoding errors
            let sanitizedData: [String: Any] = [
                "name": data["name"] as? String ?? "",
                "email": data["email"] as? String ?? "",
                "phone": data["phone"] as? String ?? "",
                "dateOfBirth": data["dateOfBirth"] as? String ?? "",
                "height": data["height"] as? String ?? "",
                "weight": data["weight"] as? String ?? "",
                "sex": data["sex"] as? String ?? "",
                "userID": data["userID"] as? String ?? ""
            ]
            
            print("Sanitized Firestore data: \(sanitizedData)")
            
            do {
                // Decode to User model
                let user = try Firestore.Decoder().decode(User.self, from: sanitizedData)
                print("Decoded User: \(user)")
                
                //cache user data model.
                self.cachedUser = user
                // Update profile screen
                DispatchQueue.main.async {
                    self.updateProfileView(with: user)
                }
            } catch let decodeError {
                print("Failed to decode user data: \(decodeError.localizedDescription)")
            }
        }
    }
    
    private func updateProfileView(with user: User) {
        profileScreen.updateData(
            name: user.name,
            email: user.email,
            phone: user.phone ?? "Not provided",
            dob: user.dateOfBirth ?? "Not provided",
            sex: user.height ?? "Not provided",
            weight: user.weight ?? "Not provided",
            height: user.sex ?? "Not provided"
        )
    }
    
    @objc private func editButtonTapped() {
        guard let user = cachedUser else {
            print("Error: User data not loaded or cached")
            return
        }
        
        print("Using cached user data for editing: \(user)")
        
        // 跳转到 EditProfileScreenViewController
        let editProfileVC = EditProfileViewController()
        editProfileVC.user = cachedUser
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }

    
}
