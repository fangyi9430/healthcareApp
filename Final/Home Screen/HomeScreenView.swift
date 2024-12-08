//
//  HomeScreenView.swift
//  Final
//
//  Created by Eva H on 11/21/24.
//

import UIKit

class HomeScreenView: UIView {
    
    // Welcome Label
    var welcomeLabel = UILabel()
    
    var buttonAdd: UIButton!
    
    var labelInstruct: UILabel!
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        // Set up the welcome label
        setupWelcomeLabel()
        setupLabelInstruct()
        setupbuttonAdd()
        
        // Initialize constraints
        initConstraints()
    }
    
    func setupLabelInstruct() {
        labelInstruct = UILabel()
        labelInstruct.text = "Quckly Adding a record of your symptoms by pressing the button bellow."
        labelInstruct.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelInstruct.textColor = .black
        labelInstruct.textAlignment = .left
        labelInstruct.numberOfLines = 0
        labelInstruct.lineBreakMode = .byWordWrapping
        labelInstruct.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelInstruct)
    }
    
    func setupbuttonAdd() {
        buttonAdd = UIButton()
        buttonAdd.backgroundColor = .systemBlue
        buttonAdd.setTitle("+", for: .normal)
        buttonAdd.setTitleColor(.white, for: .normal)
        buttonAdd.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        buttonAdd.layer.cornerRadius = 50
        buttonAdd.layer.masksToBounds = true
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAdd)
        
    }
    
    // Function to set up the welcome label
    private func setupWelcomeLabel() {
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24) // Customize font size and make it bold
        welcomeLabel.textColor = .black // Customize text color
        welcomeLabel.textAlignment = .center // Center align the text
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        welcomeLabel.text = "Welcome to FileLife" // Set default text
        self.addSubview(welcomeLabel)
    }
    
    
    // Set up constraints
    private func initConstraints() {
        NSLayoutConstraint.activate([
            // Center the label horizontally in the view
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            // Position the label closer to the top of the screen
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),// Reduced padding
            
            labelInstruct.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            labelInstruct.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelInstruct.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelInstruct.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            buttonAdd.topAnchor.constraint(equalTo: labelInstruct.bottomAnchor, constant: 20),
            buttonAdd.heightAnchor.constraint(equalToConstant: 200),
            buttonAdd.widthAnchor.constraint(equalToConstant: 200),
            buttonAdd.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
