//
//  HomeViewController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 17/04/25.
//

import UIKit
import Foundation

final class HomeViewController: UIViewController {
    private let contentView: HomeView
    private let delegate: any HomeFlowDelegate
    
    init(contentView: HomeView, delegate: any HomeFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
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
    
    private func setup() {
        view.addSubview(contentView)
        buildHierarchy()
    }
    
    private func buildHierarchy() {
        setupContentViewToBounds(contentView: contentView)
    }
    
    private func logoutAction() {
        UserDefaultsManager.removeUser()
        delegate.logout()
    }
}
