//
//  HistoryView.swift
//  Final
//
//  Created by Eva H on 11/22/24.
//

import UIKit

class HistoryView: UIView {

    // Title Label
    private let titleLabel = UILabel()

    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white // Set the background color

        // Set up the title label
        setupTitleLabel()

        // Set up constraints
        initConstraints()
    }

    // Function to set up the title label
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24) // Set font size and weight
        titleLabel.textColor = .black // Set text color
        titleLabel.textAlignment = .center // Center align the text
        titleLabel.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        titleLabel.text = "Here is your history" // Set label text
        self.addSubview(titleLabel) // Add to the view
    }

    // Function to set up constraints
    private func initConstraints() {
        NSLayoutConstraint.activate([
            // Center the label horizontally in the view
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            // Position the label near the top
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
