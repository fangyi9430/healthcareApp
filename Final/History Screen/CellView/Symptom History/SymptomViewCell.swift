//
//  SymptomViewCell.swift
//  Final
//
//  Created by Eva H on 12/8/24.
//

import UIKit

protocol SymptomViewCellDelegate: AnyObject {
    func didTapDeleteButton(for cell: SymptomViewCell)
}

class SymptomViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelCategory: UILabel!
    var labelHours: UILabel!
    var labelMinutes: UILabel!
    var labelNotes: UILabel!
    var labelTimestamp: UILabel!
    var deleteButton: UIButton!
    
    weak var delegate: SymptomViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelCategory()
        setupLabelHours()
        setupLabelMinutes()
        setupLabelNotes()
        setupLabelTimestamp()
        setupDeleteButton()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.isUserInteractionEnabled = true
        self.contentView.isUserInteractionEnabled = true
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelCategory() {
        labelCategory = UILabel()
        labelCategory.font = UIFont.boldSystemFont(ofSize: 20)
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCategory)
    }
    
    func setupLabelHours() {
        labelHours = UILabel()
        labelHours.font = UIFont.systemFont(ofSize: 14)
        labelHours.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelHours)
    }
    
    func setupLabelMinutes() {
        labelMinutes = UILabel()
        labelMinutes.font = UIFont.systemFont(ofSize: 14)
        labelMinutes.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelMinutes)
    }
    
    func setupLabelNotes() {
        labelNotes = UILabel()
        labelNotes.font = UIFont.systemFont(ofSize: 14)
        labelNotes.numberOfLines = 0 // Allow multiple lines
        labelNotes.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelNotes)
    }
    
    func setupLabelTimestamp() {
        labelTimestamp = UILabel()
        labelTimestamp.font = UIFont.systemFont(ofSize: 12)
        labelTimestamp.textColor = .gray
        labelTimestamp.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestamp)
    }
    
    func setupDeleteButton() {
        deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        deleteButton.backgroundColor = .clear
        deleteButton.isUserInteractionEnabled = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        wrapperCellView.addSubview(deleteButton)
    }
    
    @objc private func deleteButtonTapped() {
        print("DEBUG: Delete button tapped!")
        delegate?.didTapDeleteButton(for: self)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Wrapper cell view constraints
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            // Category label constraints
            labelCategory.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelCategory.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelCategory.trailingAnchor.constraint(lessThanOrEqualTo: deleteButton.leadingAnchor, constant: -8),
            
            // Hours label constraints
            labelHours.topAnchor.constraint(equalTo: labelCategory.bottomAnchor, constant: 8),
            labelHours.leadingAnchor.constraint(equalTo: labelCategory.leadingAnchor),
            
            // Minutes label constraints
            labelMinutes.topAnchor.constraint(equalTo: labelCategory.bottomAnchor, constant: 8),
            labelMinutes.leadingAnchor.constraint(equalTo: labelHours.trailingAnchor, constant: 8),
            
            // Notes label constraints
            labelNotes.topAnchor.constraint(equalTo: labelHours.bottomAnchor, constant: 8),
            labelNotes.leadingAnchor.constraint(equalTo: labelCategory.leadingAnchor),
            labelNotes.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            
            // Timestamp label constraints
            labelTimestamp.topAnchor.constraint(equalTo: labelNotes.bottomAnchor, constant: 8),
            labelTimestamp.leadingAnchor.constraint(equalTo: labelNotes.leadingAnchor),
            labelTimestamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelTimestamp.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8),
            
            // Delete Button constraints
            deleteButton.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            deleteButton.widthAnchor.constraint(equalToConstant: 60),
            deleteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with symptom: Symptom) {
        labelCategory.text = "Category: \(symptom.category)"
        labelHours.text = "Hours: \(symptom.duration.hours)"
        labelMinutes.text = "Minutes: \(symptom.duration.minutes)"
        labelNotes.text = "Notes: \(symptom.notes)"
        labelTimestamp.text = "Recorded: \(symptom.timestamp)"
    }
}
