//
//  SplashView.swift
//  Reminder
//
//  Created by Gabriel Roveri on 01/04/25.
//

import Foundation
import UIKit

final class SplashView: UIView {

    public let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    private func setupUI() {
        addSubview(logoImageView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -MetricsConstants.medium)
        ])
    }
}
