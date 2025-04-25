//
//  ButtonHomeView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 23/04/25.
//

import UIKit

final class ButtonHomeView: UIView {
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorsConstants.gray600
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.subHeading
        label.textColor = ColorsConstants.gray100
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.body
        label.textColor = ColorsConstants.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "chevron.right"))
        imageView.tintColor = ColorsConstants.gray300
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()
    
    init(icon: UIImage?, title: String, description: String) {
        super.init(frame: .zero)
        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = description
        backgroundColor = ColorsConstants.gray700
        layer.cornerRadius = 7
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        iconView.addSubview(iconImageView)
        addSubviews(iconView, titleLabel, descriptionLabel, arrowImageView)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.medium),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            iconView.heightAnchor.constraint(equalToConstant: 80),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: MetricsConstants.huge),
            iconImageView.heightAnchor.constraint(equalToConstant: MetricsConstants.huge),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: MetricsConstants.medium),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: MetricsConstants.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MetricsConstants.medium),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 16),
            
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
}
