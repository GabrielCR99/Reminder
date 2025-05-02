//
//  Chcekbox.swift
//  Reminder
//
//  Created by Gabriel Roveri on 25/04/25.
//

import UIKit

final class Checkbox: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.input
        label.textColor = ColorsConstants.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let checkbox: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.init(systemName: "square"), for: .normal)
        button.tintColor = ColorsConstants.gray400
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    init (title: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView () {
        addSubviews(checkbox, titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkbox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 24),
            checkbox.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: MetricsConstants.small),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }
}
