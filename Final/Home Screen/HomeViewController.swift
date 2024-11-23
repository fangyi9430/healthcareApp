//
//  HomeViewController.swift
//  Final
//
//  Created by Eva H on 11/21/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController {
    
    var currentUser: FirebaseAuth.User?
    
    // Reference to the HomeScreenView
    let homeView = HomeScreenView()
    
    override func loadView() {
        // Set the custom view
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayName = Auth.auth().currentUser?.displayName ?? "Anonymous"
        homeView.welcomeLabel.text = "Hello \(displayName)! Welcome to FileLife."
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
