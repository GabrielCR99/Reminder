//
//  HomeFlowDelegate.swift
//  Reminder
//
//  Created by Gabriel Roveri on 17/04/25.
//

public protocol HomeFlowDelegate: AnyObject {
    func navigateToNewRecipes()
    func logout()
    func navigateToMyRecipes()
}
