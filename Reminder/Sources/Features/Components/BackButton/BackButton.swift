//
//  BackButton.swift
//  Reminder
//
//  Created by Gabriel Roveri on 08/05/25.
//

import UIKit

final class BackButton: UIView {
    var tapAction: (() -> Void)?
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(named: "ArrowLeft"), for: .normal)
        button.tintColor = ColorsConstants.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc
    private func handleTap() {
        tapAction?()
    }
    
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
        ])
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
