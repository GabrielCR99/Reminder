//
//  ReminderFlowController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 13/04/25.
//

import Foundation
import UIKit

final class ReminderFlowController {
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllerFactory: any ViewControllersFactoryProtocol

    // MARK: - Splash

    // MARK: - Init
    public init() {
        viewControllerFactory = ViewControllersFactory()
    }

    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Start flow
    public func start() -> UINavigationController? {
        let startVC = viewControllerFactory.makeSplashController(delegate: self)
        navigationController = UINavigationController(rootViewController: startVC)

        return navigationController
    }
}

// MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        navigationController?.dismiss(animated: false)
        let vc = viewControllerFactory.makeHomeViewController(delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Splash
extension ReminderFlowController: SplashFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheet = viewControllerFactory.makeLoginBottomSheetViewController(delegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        navigationController?.present(loginBottomSheet, animated: false) {
            loginBottomSheet.animateShow()
        }
    }
}

// MARK: - Home
extension ReminderFlowController: HomeFlowDelegate {
    func navigateToNewRecipes() {
        let vc = viewControllerFactory.makeNewRecipesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func logout() {
        navigationController?.popViewController(animated: true)
        openLoginBottomSheet()
    }

    func navigateToMyRecipes() {
        let vc = viewControllerFactory.makeMyRecipesViewController(delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - MyRecipes
extension ReminderFlowController: MyRecipesFlowDelegate {
    func goToNewRecipes() {
        navigateToNewRecipes()
    }

    func popScreen() {
        navigationController?.popViewController(animated: true)
    }
}
