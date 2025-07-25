//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by Gabriel Roveri on 10/04/25.
//

import UIKit

final class LoginBottomSheetViewController: UIViewController {
    let viewModel = LoginBottomSheetViewModel()
    let contentView: LoginBottomSheetView
    let handleAreaHeight: CGFloat = 50
    public weak var delegate: (any LoginBottomSheetFlowDelegate)?

    public init(contentView: LoginBottomSheetView, delegate: (any LoginBottomSheetFlowDelegate)? = nil) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        setupUI()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height
        contentView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        // UIView.animate(withDuration: 0.3) {
        // self.view.frame.origin.y = -keyboardHeight / 2
        // }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        contentView.transform = .identity
        // UIView.animate(withDuration: 0.3) {
        // self.view.frame.origin.y = 0
        // }
    }

    private func setupUI() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }

    private func bindViewModel() {
        viewModel.didFinishAuthentication = { [weak self] in
            self?.presentSaveLoginAlert(email: $0)
        }
        viewModel.errorResult = { [weak self] in
            self?.presentErrorAlert(message: $0)
        }
    }

    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Erro ao logar",
                                                message: message,
                                                preferredStyle: .alert
        )

        let retryAction = UIAlertAction(title: "Tentar novamente", style: .default)
        alertController.addAction(retryAction)
        present(alertController, animated: true)
    }

    private func presentSaveLoginAlert(email: String) {
        let alertController = UIAlertController(title: "Salvar acesso",
                                                message: "Would you like to save your login credentials?",
                                                preferredStyle: .alert
        )
        let saveAction = UIAlertAction(title: "Sim", style: .default) { _ in
            let user = User(email: email, isUserSaved: true)
            UserDefaultsManager.saveUser(user)
            self.delegate?.navigateToHome()
        }
        let cancelAction = UIAlertAction(title: "Não", style: .cancel) { _ in
            self.delegate?.navigateToHome()
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    func animateShow(with completion: (() -> Void)? = nil ) {
        view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
            completion?()
        }
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func loginBottomSheetViewDidTapLoginButton(user: String, password: String) {
        viewModel.login(username: user, password: password)
    }
}
