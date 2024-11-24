//
//  HistoryViewController.swift
//  Final
//
//  Created by Eva H on 11/21/24.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // Reference to the custom view
    var historyView = HistoryView()

    override func loadView() {
        // Set the custom view as the main view
        view = historyView
    }
    
    override func viewDidLoad() {
        
        
        //label title
        let titleLabel = UILabel()
        titleLabel.text = "History"
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
        
        //--------//
        
        super.viewDidLoad()
        
        // Set navigation bar preferences
       
    }
}
