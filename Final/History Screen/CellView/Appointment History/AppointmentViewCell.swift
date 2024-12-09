//
//  AppointmentViewCell.swift
//  Final
//
//  Created by Eva H on 12/7/24.
//

import UIKit

protocol AppointmentViewCellDelegate: AnyObject {
    func didTapCancelButton(for cell: AppointmentViewCell)
}

class AppointmentViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelNameOfDoctor: UILabel!
    var labelDate: UILabel!
    var labelTimeSlot: UILabel!
    var cancelButton: UIButton!
    weak var delegate: AppointmentViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelNameOfDoctor()
        setupLabelDate()
        setupLabelTimeSlot()
        setupCancelButton()
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
    
    func setupLabelNameOfDoctor() {
        labelNameOfDoctor = UILabel()
        labelNameOfDoctor.font = UIFont.boldSystemFont(ofSize: 20)
        labelNameOfDoctor.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelNameOfDoctor)
    }
    
    func setupLabelDate() {
        labelDate = UILabel()
        labelDate.font = UIFont.boldSystemFont(ofSize: 14)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }
    
    func setupLabelTimeSlot() {
        labelTimeSlot = UILabel()
        labelTimeSlot.font = UIFont.boldSystemFont(ofSize: 14)
        labelTimeSlot.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimeSlot)
    }
    
    func setupCancelButton() {
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        cancelButton.backgroundColor = .clear
        cancelButton.isUserInteractionEnabled = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        wrapperCellView.addSubview(cancelButton)
    }
    
    @objc private func cancelButtonTapped() {
        print("DEBUG: Cancel button tapped!")
        delegate?.didTapCancelButton(for: self)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Wrapper cell view constraints
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            // Doctor name constraints
            labelNameOfDoctor.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelNameOfDoctor.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelNameOfDoctor.trailingAnchor.constraint(lessThanOrEqualTo: cancelButton.leadingAnchor, constant: -8),
            
            // Date label constraints
            labelDate.topAnchor.constraint(equalTo: labelNameOfDoctor.bottomAnchor, constant: 4),
            labelDate.leadingAnchor.constraint(equalTo: labelNameOfDoctor.leadingAnchor),
            
            // Time slot label constraints
            labelTimeSlot.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 4),
            labelTimeSlot.leadingAnchor.constraint(equalTo: labelDate.leadingAnchor),
            labelTimeSlot.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8),
            
            // Cancel Button constraints
            cancelButton.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            cancelButton.widthAnchor.constraint(equalToConstant: 60),
            cancelButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with appointment: Appointment) {
        labelNameOfDoctor.text = "Dr. \(appointment.doctorName)"
        labelDate.text = "Date: \(appointment.date)"
        labelTimeSlot.text = "Time: \(appointment.timeSlot)"
    }
}
