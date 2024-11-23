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
    
    let mainScreen = MainScreenView()
    
    var contactsList = [Contact]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the notes!"
                //                self.mainScreen.floatingButtonAddContact.isEnabled = false
                //                self.mainScreen.floatingButtonAddContact.isHidden = true
                
                //MARK: Reset tableView...
                //                self.contactsList.removeAll()
                //                self.mainScreen.tableViewContacts.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the contacts list...
                //                self.database.collection("users")
                //                    .document((self.currentUser?.email)!)
                //                    .collection("contacts")
                //                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                //                        if let documents = querySnapshot?.documents{
                //                            self.contactsList.removeAll()
                //                            for document in documents{
                //                                do{
                //                                    let contact  = try document.data(as: Contact.self)
                //                                    self.contactsList.append(contact)
                //                                }catch{
                //                                    print(error)
                //                                }
                //                            }
                //                            self.contactsList.sort(by: {$0.name < $1.name})
                //
                //                        }
                //                    })
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = "My Profile"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20) // Customize font and size
        titleLabel.textColor = .black // Customize color
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a container view for precise centering
        let titleContainer = UIView()
        titleContainer.addSubview(titleLabel)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to center the label
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor)
        ])
        
        
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        //        view.bringSubviewToFront(mainScreen.floatingButtonAddContact)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
}
