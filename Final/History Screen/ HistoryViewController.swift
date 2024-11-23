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
        super.viewDidLoad()
        
        // Set navigation bar preferences
        navigationController?.navigationBar.prefersLargeTitles = true
//        title = "History" // Set the navigation title
    }
}
