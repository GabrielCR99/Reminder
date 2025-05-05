//
//  Input.swift
//  Reminder
//
//  Created by Gabriel Roveri on 25/04/25.
//

import UIKit

final class Input: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.label
        label.textColor = ColorsConstants.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = TextHeadings.input
        textField.textColor = ColorsConstants.gray100
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorsConstants.gray800
        textField.layer.borderWidth = 1
        textField.layer.borderColor = ColorsConstants.gray400.cgColor
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    } ()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        textField.placeholder = placeholder
        
        setupView()
        setupPlaceholder()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlaceholder() {
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: ColorsConstants.gray200]
        )
    }
    
    private func setupView() {
        addSubviews(titleLabel, textField)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 85),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MetricsConstants.small),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 56),
            ])
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
}
