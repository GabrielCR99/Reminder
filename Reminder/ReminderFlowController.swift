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
    //    private let viewControllerFactory
    
    // MARK: - Splash
    
    // MARK: - Init
    public init() {}
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Start flow
    public func start() -> UINavigationController? {
        let startVC = UIViewController()
        navigationController = UINavigationController(rootViewController: startVC)
        
        return navigationController
    }
    
}

// MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        navigationController?.dismiss(animated: true)
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBlue
        navigationController?.pushViewController(vc, animated: true)
    }
}
