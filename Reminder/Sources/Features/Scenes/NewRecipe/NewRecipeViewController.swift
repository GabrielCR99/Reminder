//
//  NewRecipeViewController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 24/04/25.
//

import Foundation
import UIKit
import Lottie

final class NewRecipeViewController: UIViewController {
    private let newRecipeView = NewRecipeView()
    private let viewModel = NewRecipeViewModel()

    private let successAnimation: LottieAnimationView = {
        let animation = LottieAnimationView(name: "SuccessAnimation")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        animation.isHidden = true
        animation.translatesAutoresizingMaskIntoConstraints = false

        return animation
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }

    private func setupView() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        view.backgroundColor = ColorsConstants.gray800
        view.addSubviews(newRecipeView, successAnimation)

        setupConstraints()
    }

    private func setupConstraints() {
        newRecipeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newRecipeView.topAnchor.constraint(equalTo: view.topAnchor),
            newRecipeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newRecipeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newRecipeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            successAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            successAnimation.heightAnchor.constraint(equalToConstant: 300),
            successAnimation.widthAnchor.constraint(equalToConstant: 300)
            ])
    }

    private func setupActions() {
        newRecipeView.backButton.tapAction = { [weak self] in
            self?.backButtonTapped()
        }
        newRecipeView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    @objc
    private func addButtonTapped() {
        let remedy = newRecipeView.remedyInput.getText()
        let time = newRecipeView.timeInput.getText()
        let recurrence = newRecipeView.recurrenceInput.getText()
        let takeNow = false

        viewModel.addRecipe(remedy: remedy, time: time, recurrence: recurrence, takeNow: takeNow)
        clearInputs()
        playSuccessAnimation()
//        navigationController?.popViewController(animated: true)
    }

    private func clearInputs() {
        // Clear all text fields
        [newRecipeView.remedyInput,
         newRecipeView.timeInput,
         newRecipeView.recurrenceInput].forEach { $0.textField.text = "" }

        // Disable add button and update its appearance
        updateAddButtonState(enabled: false)

        // Reset focus to the first field for better UX
        newRecipeView.remedyInput.textField.becomeFirstResponder()
    }

    private func updateAddButtonState(enabled: Bool) {
        newRecipeView.addButton.isEnabled = enabled
        newRecipeView.addButton.backgroundColor = enabled ? ColorsConstants.primaryRedBase : ColorsConstants.gray500
    }

    private func playSuccessAnimation() {
        successAnimation.isHidden = false
        successAnimation.play { [weak self] finished in
            if finished {
                self?.successAnimation.isHidden = true
            }

        }
    }

    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
