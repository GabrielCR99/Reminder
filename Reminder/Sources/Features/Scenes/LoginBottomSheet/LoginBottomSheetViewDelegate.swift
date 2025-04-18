//
//  LoginBottomSheetViewDelegate.swift
//  Reminder
//
//  Created by Gabriel Roveri on 11/04/25.
//


import Foundation

public protocol LoginBottomSheetViewDelegate: AnyObject {
    func loginBottomSheetViewDidTapLoginButton(user: String, password: String)
}
