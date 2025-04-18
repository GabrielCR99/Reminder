//
//  ViewControllersFactoryProtocol.swift
//  Reminder
//
//  Created by Gabriel Roveri on 15/04/25.
//

import Foundation

protocol ViewControllersFactoryProtocol {
    func makeSplashController(delegate: any SplashFlowDelegate) -> SplashViewController
    func makeLoginBottomSheetViewController(delegate: any LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
    func makeHomeViewController(delegate: any HomeFlowDelegate) -> HomeViewController
}
