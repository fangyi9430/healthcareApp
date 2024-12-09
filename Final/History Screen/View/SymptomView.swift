
//
//  SymptomView.swift
//  Final
//
//  Created by Eva H on 11/26/24.
//

import UIKit

class SymptomView: UIView {
    
    var tableViewSymptoms: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewSymptoms()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewSymptoms() {
        tableViewSymptoms = UITableView()
        tableViewSymptoms.register(SymptomViewCell.self, forCellReuseIdentifier: Configs.tableViewSymptoms)
        tableViewSymptoms.translatesAutoresizingMaskIntoConstraints = false
        tableViewSymptoms.rowHeight = UITableView.automaticDimension
        tableViewSymptoms.estimatedRowHeight = 150
        self.addSubview(tableViewSymptoms)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            // Table View constraints
            tableViewSymptoms.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableViewSymptoms.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tableViewSymptoms.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            tableViewSymptoms.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
