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
        
        //label title
        let titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a container view
        let titleContainer = UIView()
        titleContainer.addSubview(titleLabel)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to the label
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor)
        ])
        
        // Assign the container to navigationItem.titleView
        navigationItem.titleView = titleContainer
        
        //-----------------------------//
        
        
        let displayName = Auth.auth().currentUser?.displayName ?? "Anonymous"
        homeView.welcomeLabel.text = "Hello \(displayName)! Welcome to FileLife."
        
    }
}
