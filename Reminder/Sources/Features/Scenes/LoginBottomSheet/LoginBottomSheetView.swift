//
//  LoginBottomSheetView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 10/04/25.
//

import UIKit
import Foundation

final class LoginBottomSheetView: UIView {
    public weak var delegate: (any LoginBottomSheetViewDelegate)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "login.welcome.title".localized
        label.isUserInteractionEnabled = true
        label.font = TextHeadings.subHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let loginTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "login.loginText.title".localized
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let passwordTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "login.password.title".localized
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let handleArea:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = MetricsConstants.tiny
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "login.email.placeholder".localized
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    } ()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "login.password.placeholder".localized
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    } ()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login.button.title".localized, for: .normal)
        button.backgroundColor = ColorsConstants.primaryRedBase
        button.layer.cornerRadius = MetricsConstants.medium
        button.tintColor = .white
        button.titleLabel?.font = TextHeadings.subHeading
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        let exampleGest = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        titleLabel.addGestureRecognizer(exampleGest)
    }
    
    @objc
    private func handleTap() {
        debugPrint("Tapped")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = MetricsConstants.small
        
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(loginTextFieldLabel)
        addSubview(passwordTextFieldLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: MetricsConstants.huge),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.medium),
            
            loginTextFieldLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MetricsConstants.medium),
            loginTextFieldLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.medium),
            
            emailTextField.topAnchor.constraint(equalTo: loginTextFieldLabel.bottomAnchor, constant: MetricsConstants.medium),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.medium),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.medium),
            emailTextField.heightAnchor.constraint(equalToConstant: MetricsConstants.inputSize),
            
            passwordTextFieldLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: MetricsConstants.medium),
            passwordTextFieldLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.medium),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldLabel.bottomAnchor, constant: MetricsConstants.medium),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.medium),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.medium),
            passwordTextField.heightAnchor.constraint(equalToConstant: MetricsConstants.inputSize),
            
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -MetricsConstants.huge),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MetricsConstants.medium),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MetricsConstants.medium),
            loginButton.heightAnchor.constraint(equalToConstant: MetricsConstants.buttoSize),
            
        ])
    }
    
    @objc
    private func loginButtonTapped() {
        delegate?.loginBottomSheetViewDidTapLoginButton(user: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
}
