
//
//  DoctorAppointmentScreenView.swift
//  Final
//
//  Created by Eva H on 11/26/24.
//

import UIKit

class DoctorAppointmentScreenView: UIView {
    
    var tableViewDoctors: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewDoctors()
        initConstraints()
    }
    
    func setupTableViewDoctors(){
        tableViewDoctors = UITableView()
        tableViewDoctors.register(DoctorsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewDoctorsID )
        tableViewDoctors.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewDoctors)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewDoctors.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewDoctors.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewDoctors.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableViewDoctors.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
