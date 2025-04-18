//
//  ViewController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 01/04/25.
//

import UIKit
import Foundation

final class SplashViewController: UIViewController {
    let contentView: SplashView
    public weak var delegate: (any SplashFlowDelegate)?
    
    public init(contentView: SplashView, delegate: any SplashFlowDelegate) {
        self.delegate = delegate
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setup()
        startBreathingAnimation()
    }
    
    private func decideNavigationFlow() {
        if let user = UserDefaultsManager.loadUser(), user.isUserSaved {
            delegate?.navigateToHome()
        } else {
            showLoginBottomSheet()
        }
    }

    
    private func setup() {
        view.addSubview(contentView)
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = ColorsConstants.primaryRedBase
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func showLoginBottomSheet() {
        animateLogoUp()
        delegate?.openLoginBottomSheet()
    }
}


// MARK: - Animations
extension SplashViewController {
    private func startBreathingAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0.0, animations: {
            self.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            self.decideNavigationFlow()
        })
    }
    
    private func animateLogoUp() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            self.contentView.logoImageView.transform = self.contentView.logoImageView.transform.translatedBy(x: 0, y: -150)
        })
    }
    
}
