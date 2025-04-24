//
//  HomeView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 17/04/25.
//

import Foundation
import UIKit

final class HomeView: UIView {
    public weak var delegate: (any HomeViewDelegate)?
    private let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = ColorsConstants.gray600
        view.isUserInteractionEnabled = true
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
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = MetricsConstants.medium
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
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = TextHeadings.heading
        textField.textColor = ColorsConstants.gray100
        textField.returnKeyType = .done
        textField.placeholder = "Insira seu nome"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
        
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
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    private func setupTextField() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidEndEditing), for: .editingDidEnd)
        nameTextField.delegate = self
    }
    
    @objc
    private func nameTextFieldDidEndEditing() {
        let userName = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(userName)
    }
    
    private func setupView() {
        addSubview(profileBackground)
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(nameTextField)
        
        addSubview(contentBackground)
        contentBackground.addSubview(feedbackButton)
        
        setupConstraints()
        setupImageGesture()
        
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        profileImage.addGestureRecognizer(backgroundTapGesture)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: topAnchor),
            profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileBackground.heightAnchor.constraint(equalToConstant: MetricsConstants.backgroundProfileSize),
            
            profileImage.topAnchor.constraint(equalTo: profileBackground.safeAreaLayoutGuide.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: MetricsConstants.medium),
            profileImage.heightAnchor.constraint(equalToConstant: MetricsConstants.profileImageSize),
            profileImage.widthAnchor.constraint(equalToConstant: MetricsConstants.profileImageSize),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: MetricsConstants.small),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: MetricsConstants.little),
            nameTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            
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
    
    private func setupImageGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleImageTap() {
        dump(#function)
        delegate?.didTapProfileImage()
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let userName = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(userName)
        
        return true
    }
}
