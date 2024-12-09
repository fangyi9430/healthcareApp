//
//  MainScreenView.swift
//  Final
//
//  Created by Eva H on 11/22/24.
//

import UIKit

class MainScreenView: UIView {
    
    var profileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var phoneLabel: UILabel!
    private var dobLabel: UILabel!
    private var heightLabel: UILabel!
    private var weightLabel: UILabel!
    private var sexLabel: UILabel!
    var editButton: UIButton!
    
    private var labelSignInNotification: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSignInNotificationLabel()
        setupProfileImageView()
        setupNameLabel()
        setupEmailLabel()
        setupPhoneLabel()
        setupDobLabel()
        setupHeightLabel()
        setupWeightLabel()
        setupSexLabel()
        setupEditButton()
        
        setLoggedOutState()// default logged out.
        
        initConstraints()
    }
    
    //MARK: initializing the UI elements...
    
    func setupSignInNotificationLabel() {
        labelSignInNotification = UILabel()
        labelSignInNotification.text = "Please sign in"
        labelSignInNotification.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelSignInNotification.textColor = .red
        labelSignInNotification.textAlignment = .center
        labelSignInNotification.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelSignInNotification)
    }
    
    func setupProfileImageView() {
        profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImageView)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        nameLabel.text = "Name: "
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textAlignment = .center
        emailLabel.textColor = .black
        emailLabel.text = "Email: "
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailLabel)
    }
    
    func setupPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.font = UIFont.systemFont(ofSize: 16)
        phoneLabel.textAlignment = .center
        phoneLabel.textColor = .darkGray
        phoneLabel.text = "Phone: "
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneLabel)
    }
    
    func setupDobLabel() {
        dobLabel = UILabel()
        dobLabel.font = UIFont.systemFont(ofSize: 16)
        dobLabel.textAlignment = .center
        dobLabel.textColor = .darkGray
        dobLabel.text = "date of birth: "
        dobLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dobLabel)
    }
    
    func setupHeightLabel() {
        heightLabel = UILabel()
        heightLabel.font = UIFont.systemFont(ofSize: 16)
        heightLabel.textAlignment = .center
        heightLabel.textColor = .darkGray
        heightLabel.text = "Height: "
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(heightLabel)
    }
    
    func setupWeightLabel() {
        weightLabel = UILabel()
        weightLabel.font = UIFont.systemFont(ofSize: 16)
        weightLabel.textAlignment = .center
        weightLabel.textColor = .darkGray
        weightLabel.text = "Weight: "
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightLabel)
    }
    
    func setupSexLabel() {
        sexLabel = UILabel()
        sexLabel.font = UIFont.systemFont(ofSize: 16)
        sexLabel.textAlignment = .center
        sexLabel.textColor = .darkGray
        sexLabel.text = "Sex: "
        sexLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sexLabel)
    }
    
    func setupEditButton() {
        editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        editButton.setTitleColor(.white, for: .normal)
        editButton.backgroundColor = .systemBlue
        editButton.layer.cornerRadius = 8
        editButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editButton)
    }
    
    
    
    
    //MARK: setting up constraints...
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelSignInNotification.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelSignInNotification.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelSignInNotification.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            dobLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            dobLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dobLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            heightLabel.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 10),
            heightLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            heightLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weightLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            sexLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10),
            sexLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sexLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            editButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 120),
            editButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func updateData(name: String, email: String, phone:String, dob:String, sex: String, weight:String, height:String) {
        nameLabel.text = "Name: \(name)"
        emailLabel.text = "Email: \(email)"
        phoneLabel?.text = "Phone: \(phone)"
        dobLabel?.text = "Date of Birth: \(dob)"
        heightLabel?.text = "Height: \(height)"
        weightLabel?.text = "Weight: \(weight)"
        sexLabel?.text = "Sex: \(sex)"
        
    }
    
    func setLoggedOutState() {
        labelSignInNotification.isHidden = false
        profileImageView.isHidden = true
        nameLabel.isHidden = true
        emailLabel.isHidden = true
        phoneLabel.isHidden = true
        dobLabel.isHidden = true
        heightLabel.isHidden = true
        weightLabel.isHidden = true
        sexLabel.isHidden = true
        editButton.isHidden = true
    }
        
    func setLoggedInState() {
        labelSignInNotification.isHidden = true
        profileImageView.isHidden = false
        nameLabel.isHidden = false
        emailLabel.isHidden = false
        phoneLabel.isHidden = false
        dobLabel.isHidden = false
        heightLabel.isHidden = false
        weightLabel.isHidden = false
        sexLabel.isHidden = false
        editButton.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
