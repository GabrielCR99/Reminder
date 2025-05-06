//
//  NewRecipeViewController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 24/04/25.
//

import Foundation
import UIKit

final class NewRecipeViewController: UIViewController {
    private let newRecipeView = NewRecipeView()
    private let viewModel = NewReceiptViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    private func setupView() {
        view.backgroundColor = ColorsConstants.gray800
        view.addSubview(newRecipeView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        newRecipeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newRecipeView.topAnchor.constraint(equalTo: view.topAnchor),
            newRecipeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newRecipeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newRecipeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func setupActions() {
        newRecipeView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        newRecipeView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addButtonTapped() {
        let remedy = newRecipeView.remedyInput.getText()
        let time = newRecipeView.timeInput.getText()
        let recurrence = newRecipeView.recurrenceInput.getText()
        let takeNow = false
        
        viewModel.addReceipt(remedy: remedy, time: time, recurrence: recurrence, takeNow: takeNow)
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
