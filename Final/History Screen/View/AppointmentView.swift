
//
//  AppointmentView.swift
//  Final
//
//  Created by Eva H on 11/26/24.
//

import UIKit

class AppointmentView: UIView {
    
    var buttonAddAppointment: UIButton!
    var tableViewAppointments: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupButtonAddAppointment()
        setupTableViewAppointmentHistory()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonAddAppointment() {
        buttonAddAppointment = UIButton(type: .system)
        buttonAddAppointment.setTitle("Make New Appointment", for: .normal)
        buttonAddAppointment.backgroundColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1.0)
        buttonAddAppointment.setTitleColor(.white, for: .normal)
        buttonAddAppointment.layer.cornerRadius = 8
        buttonAddAppointment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAddAppointment)
    }
    
    func setupTableViewAppointmentHistory() {
        tableViewAppointments = UITableView()
        tableViewAppointments.register(AppointmentViewCell.self, forCellReuseIdentifier: Configs.tableViewAppointments)
        tableViewAppointments.translatesAutoresizingMaskIntoConstraints = false
        tableViewAppointments.rowHeight = UITableView.automaticDimension
        tableViewAppointments.estimatedRowHeight = 120
        self.addSubview(tableViewAppointments)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            // Add Appointment Button constraints
            buttonAddAppointment.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonAddAppointment.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonAddAppointment.widthAnchor.constraint(equalToConstant: 250),
            buttonAddAppointment.heightAnchor.constraint(equalToConstant: 30),
            
            // Table View constraints
            tableViewAppointments.topAnchor.constraint(equalTo: buttonAddAppointment.bottomAnchor, constant: 20),
            tableViewAppointments.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tableViewAppointments.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            tableViewAppointments.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
