//
//  MyRecipesViewModel.swift
//  Reminder
//
//  Created by Gabriel Roveri on 07/05/25.
//

import UserNotifications

final class MyRecipesViewModel {
    func fetchData() -> [Medicine] {
        DBHelper.shared.fetchRecipes()
    }
    
    func deleteRecipeById(_ id: Int) {
        DBHelper.shared.deleteRecipeById(id)
    }
    
    private func removeNotification(for remedy: String) {
        let center = UNUserNotificationCenter.current()
        let identifiers = (0..<6).map { "\(remedy)_\($0)" }
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
