//
//  AddNewSymptomsView.swift
//  Final
//
//  Created by 李方一 on 12/6/24.
//

import UIKit

class AddNewSymptomsView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var buttonSelectCategory:UIButton!
    
    var saveButton: UIButton!
    
    var durationlabelTitle:UILabel!
    var hourPicker: UIPickerView!
    var minutePicker: UIPickerView!
    
    var notes:UITextView!
    var noteslabelTitle:UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupButtonSelectCategory()
        setupDurationlabelTitle()
        
        setuphourPicker()
        setuphourminutePicker()
        setupNotesLabelTitle()
        setupNotes()
        
        setupSaveButton()
        
        initConstraints()
        
    }
    
    
    func setupButtonSelectCategory() {
        buttonSelectCategory = UIButton(type: .system)
        buttonSelectCategory.setTitle("Select your symptoms", for: .normal)
        buttonSelectCategory.showsMenuAsPrimaryAction = true
        buttonSelectCategory.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectCategory)
    }
    
    func setuphourPicker(){
        hourPicker = UIPickerView()
        hourPicker.isUserInteractionEnabled = true
        hourPicker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hourPicker)
    }
    
    func setuphourminutePicker(){
        minutePicker = UIPickerView()
        minutePicker.isUserInteractionEnabled = true
        minutePicker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(minutePicker)
    }
    
    func setupDurationlabelTitle() {
        durationlabelTitle = UILabel()
        durationlabelTitle.text = "Duration"
        durationlabelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(durationlabelTitle)
    }
    
    func setupNotesLabelTitle(){
        noteslabelTitle = UILabel()
        noteslabelTitle.text = "Notes"
        noteslabelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(noteslabelTitle)
    }
    
    func setupNotes() {
        notes = UITextView()
        notes.backgroundColor = UIColor.systemGray6
        notes.font = UIFont.systemFont(ofSize: 16)
        notes.textColor = UIColor.black
        notes.isEditable = true
        notes.layer.cornerRadius = 8
        notes.layer.borderColor = UIColor.lightGray.cgColor
        notes.layer.borderWidth = 1.0
        notes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(notes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        self.addSubview(saveButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            buttonSelectCategory.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonSelectCategory.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonSelectCategory.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            durationlabelTitle.topAnchor.constraint(equalTo: buttonSelectCategory.bottomAnchor, constant: 40),
            durationlabelTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            hourPicker.topAnchor.constraint(equalTo: durationlabelTitle.bottomAnchor, constant: 10),
            hourPicker.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            hourPicker.widthAnchor.constraint(equalToConstant: 180),
            hourPicker.heightAnchor.constraint(equalToConstant: 80),
            
            minutePicker.topAnchor.constraint(equalTo: durationlabelTitle.bottomAnchor, constant: 10),
            minutePicker.leadingAnchor.constraint(equalTo: hourPicker.trailingAnchor, constant: 5),
            minutePicker.widthAnchor.constraint(equalToConstant: 180),
            minutePicker.heightAnchor.constraint(equalToConstant: 80),
            
            noteslabelTitle.topAnchor.constraint(equalTo: minutePicker.bottomAnchor, constant: 30),
            noteslabelTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            notes.topAnchor.constraint(equalTo: noteslabelTitle.bottomAnchor,constant: 5),
            notes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            notes.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            notes.heightAnchor.constraint(equalToConstant: 150),
            
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }

}
