//
//  HomeViewController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 17/04/25.
//

import UIKit
import Foundation

final class HomeViewController: UIViewController {
    private let flowDelegate: any HomeFlowDelegate
    private let contentView: HomeView
    private let viewModel: HomeViewModel

    init(contentView: HomeView, delegate: any HomeFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = delegate
        self.viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupActionForNewRecipe()
        setupNavigationBar()
        checkForExistingData()
    }

    private func checkForExistingData() {
        if UserDefaultsManager.loadUser() != nil {
            contentView.nameTextField.text = UserDefaultsManager.loadUserName()
        }

        if let savedImage = UserDefaultsManager.loadProfileImage() {
            contentView.profileImage.image = savedImage
        }
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        let logoutButton = UIBarButtonItem(
            image: UIImage(named: "Logout"),
            style: .plain) { [weak self] in
                self?.logoutAction()
            }
        logoutButton.tintColor = ColorsConstants.primaryRedBase
        navigationItem.rightBarButtonItem = logoutButton
    }

    private func setupActionForNewRecipe() {
        contentView.newPrescriptionButton.tapAction = { [weak self] in
            self?.didTapNewPrescriptionButton()
        }

        contentView.myPrescriptionsButton.tapAction = { [weak self] in
            self?.didTapMyPrescriptionsButton()
        }
    }

    private func setup() {
        view.addSubview(contentView)
        view.backgroundColor = ColorsConstants.gray600
        contentView.delegate = self
        buildHierarchy()
    }

    private func buildHierarchy() {
        setupContentViewToBounds(contentView: contentView)
    }

    private func logoutAction() {
        UserDefaultsManager.removeUser()
        flowDelegate.logout()
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapProfileImage() {
        selectProfileImage()
    }

    func didTapNewPrescriptionButton() {
        flowDelegate.navigateToNewRecipes()
    }

    func didTapMyPrescriptionsButton() {
        flowDelegate.navigateToMyRecipes()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }

    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = editedImage
            UserDefaultsManager.saveProfileImage(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
            UserDefaultsManager.saveProfileImage(originalImage)
        }

        dismiss(animated: true)
    }
}
