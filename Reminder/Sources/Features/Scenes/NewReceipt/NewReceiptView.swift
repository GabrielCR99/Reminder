//
//  NewReceiptView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 24/04/25.
//

import Foundation
import UIKit

final class NewReceiptView: UIView {
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "arrow.left"), for: .normal)
        button.tintColor = ColorsConstants.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Receipt"
        label.font = TextHeadings.heading
        label.textColor = ColorsConstants.primaryRedBase
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a new receipt to your list."
        label.font = TextHeadings.body
        label.textColor = ColorsConstants.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Receipt", for: .normal)
        button.titleLabel?.font = TextHeadings.subHeading
        button.backgroundColor = ColorsConstants.primaryRedBase
        button.layer.cornerRadius = 12
        button.setTitleColor(ColorsConstants.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    let remedyInput = Input(title: "Remedy", placeholder: "Enter a remedy")
    let timeInput = Input(title: "Time", placeholder: "Enter time")
    let recurrencyInput = Input(title: "Recurrence", placeholder: "Enter recurrence")
    let takeNowCheckbox = Checkbox(title: "Take now")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(backButton, titleLabel, descriptionLabel, addButton, remedyInput, timeInput, recurrencyInput, takeNowCheckbox)
        
        NSLayoutConstraint.activate([
            // Back Button
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: MetricsConstants.small),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: MetricsConstants.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MetricsConstants.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Remedy input
            remedyInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: MetricsConstants.medium),
            remedyInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            remedyInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Time input
            timeInput.topAnchor.constraint(equalTo: remedyInput.bottomAnchor, constant: MetricsConstants.medium),
            timeInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            timeInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Recurrency input
            recurrencyInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: MetricsConstants.medium),
            recurrencyInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            recurrencyInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            
            // Checkbox
            takeNowCheckbox.topAnchor.constraint(equalTo: recurrencyInput.bottomAnchor, constant: MetricsConstants.medium),
            takeNowCheckbox.leadingAnchor.constraint(equalTo: recurrencyInput.leadingAnchor),
            takeNowCheckbox.trailingAnchor.constraint(equalTo: recurrencyInput.trailingAnchor),
            
            // Add button
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.high),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.high),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -MetricsConstants.high),
        ])
    }
}
