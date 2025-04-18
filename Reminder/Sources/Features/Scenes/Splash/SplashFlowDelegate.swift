//
//  SplashFlowDelegate.swift
//  Reminder
//
//  Created by Gabriel Roveri on 15/04/25.
//

import Foundation

public protocol SplashFlowDelegate: AnyObject {
    func openLoginBottomSheet()
    func navigateToHome()
}
