//
//  HomeView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 17/04/25.
//

import Foundation
import UIKit

final class HomeView: UIView {
    private let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = ColorsConstants.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = MetricsConstants.medium
        view.layer.masksToBounds = true
        view.backgroundColor = ColorsConstants.gray800
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = MetricsConstants.huge
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "home.welcome.label".localized
        label.textColor = ColorsConstants.gray200
        label.font = TextHeadings.input
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = TextHeadings.heading
        label.textColor = ColorsConstants.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    } ()
    
    private let feedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("home.feedback.button.title".localized, for: .normal)
        button.backgroundColor = ColorsConstants.gray100
        button.layer.cornerRadius = MetricsConstants.medium
        button.setTitleColor(ColorsConstants.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorsConstants.gray600
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    private func setupView() {
        addSubview(profileBackground)
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(nameLabel)
        
        addSubview(contentBackground)
        contentBackground.addSubview(feedbackButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: topAnchor),
            profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileBackground.heightAnchor.constraint(equalToConstant: MetricsConstants.backgroundProfileSize),
            
            profileImage.topAnchor.constraint(equalTo: profileBackground.topAnchor, constant: MetricsConstants.huge),
            profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: MetricsConstants.medium),
            profileImage.heightAnchor.constraint(equalToConstant: MetricsConstants.profileImageSize),
            profileImage.widthAnchor.constraint(equalToConstant: MetricsConstants.profileImageSize),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: MetricsConstants.small),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: MetricsConstants.little),
            nameLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            
            contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            feedbackButton.heightAnchor.constraint(equalToConstant: MetricsConstants.buttoSize),
            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -MetricsConstants.medium),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: MetricsConstants.medium),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -MetricsConstants.medium),
            ])
    }
    
}
