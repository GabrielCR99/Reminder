//
//  MyRecipesView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 05/05/25.
//

protocol MyRecipesViewDelegate: AnyObject {
    func backButtonTapped()
    func addButtonTapped()
}

import UIKit

final class MyRecipesView: UIView {
    weak public var delegate: (any MyRecipesViewDelegate)?
    
    // MARK: - Views
    
    private let headerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = ColorsConstants.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(named: "ArrowLeft"), for: .normal)
        button.tintColor = ColorsConstants.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minhas receitas"
        label.font = TextHeadings.heading
        label.textColor = ColorsConstants.primaryBlueBase
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Acompanhe seus medicamentos cadastrados e gerencie lembretes"
        label.font = TextHeadings.body
        label.textColor = ColorsConstants.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "AddButton"), for: .normal)
        button.tintColor = ColorsConstants.primaryBlueBase
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = MetricsConstants.medium
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = ColorsConstants.gray800
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    } ()
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        setupButtonTargets()
    }
    
    // MARK: - Private methods
    
    private func setupButtonTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc
    private func addButtonTapped() {
        delegate?.addButtonTapped()
    }
    
    private func setupView() {
        addSubviews(headerBackground, contentBackground)
        headerBackground.addSubviews(backButton, titleLabel, subtitleLabel, addButton)
        contentBackground.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerBackground.topAnchor.constraint(equalTo: topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBackground.heightAnchor.constraint(equalToConstant: MetricsConstants.backgroundProfileSize),
            
            backButton.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor, constant: MetricsConstants.medium),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -MetricsConstants.small),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            addButton.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -MetricsConstants.medium),
            addButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: MetricsConstants.medium),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MetricsConstants.small),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -MetricsConstants.medium),
            
            contentBackground.topAnchor.constraint(equalTo: headerBackground.bottomAnchor, constant: -MetricsConstants.small),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: MetricsConstants.small),
            tableView.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: MetricsConstants.medium),
            tableView.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -MetricsConstants.medium),
            tableView.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor),
        ])
    }
}
