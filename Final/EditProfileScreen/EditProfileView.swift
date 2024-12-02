//
//  EditProfileView.swift
//  Final
//
//  Created by 李方一 on 12/1/24.
//

import UIKit

class EditProfileView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneTextField: UITextField!
    var dobTextField: UITextField!
    var heightTextField: UITextField!
    var weightTextField: UITextField!
    var sexTextField: UITextField!
    var saveButton: UIButton!
    var buttonTakePhoto: UIButton!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupNameLabel()
        setupEmailLabel()
        setupPhoneTextField()
        setupDobTextField()
        setupHeightTextField()
        setupWeightTextField()
        setupSexTextField()
        setupSaveButton()
        setupbuttonTakePhoto()
        
        initConstraints()
    }
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }
    
    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
    }
    
    private func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        emailLabel.textColor = .black
        emailLabel.textAlignment = .left
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailLabel)
    }
    
    private func setupPhoneTextField() {
        phoneTextField = UITextField()
        phoneTextField.placeholder = "Enter phone number"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneTextField)
    }
    
    private func setupDobTextField() {
        dobTextField = UITextField()
        dobTextField.placeholder = "Enter date of birth"
        dobTextField.borderStyle = .roundedRect
        dobTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dobTextField)
    }
    
    private func setupHeightTextField() {
        heightTextField = UITextField()
        heightTextField.placeholder = "Enter height (cm)"
        heightTextField.borderStyle = .roundedRect
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(heightTextField)
    }
    
    private func setupWeightTextField() {
        weightTextField = UITextField()
        weightTextField.placeholder = "Enter weight (kg)"
        weightTextField.borderStyle = .roundedRect
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightTextField)
    }
    
    private func setupSexTextField() {
        sexTextField = UITextField()
        sexTextField.placeholder = "Enter sex"
        sexTextField.borderStyle = .roundedRect
        sexTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sexTextField)
    }
    
    private func setupSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 8
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            
            buttonTakePhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            phoneTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            dobTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            dobTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dobTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            heightTextField.topAnchor.constraint(equalTo: dobTextField.bottomAnchor, constant: 20),
            heightTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            heightTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            weightTextField.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            weightTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weightTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            sexTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            sexTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sexTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            saveButton.topAnchor.constraint(equalTo: sexTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
