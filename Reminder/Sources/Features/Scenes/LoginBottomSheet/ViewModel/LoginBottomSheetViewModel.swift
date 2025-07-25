//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by Gabriel Roveri on 11/04/25.
//

import FirebaseAuth

final class LoginBottomSheetViewModel {
    var didFinishAuthentication: ((String) -> Void)?
    var errorResult: ((String) -> Void)?

    func login(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) {
            [weak self] result, error in
            if let error {
                dump("Error: \(error)")
                self?.errorResult?(error.localizedDescription)
            } else {
                self?.didFinishAuthentication?(username)
                debugPrint(String(describing: result))
            }
        }
    }
}
