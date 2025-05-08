//
//  NewRecipeViewModel.swift
//  Reminder
//
//  Created by Gabriel Roveri on 02/05/25.
//

final class NewRecipeViewModel {
    func addRecipe(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        DBHelper.shared.insertRecipe(remedy: remedy, time: time, recurrence: recurrence, takeNow: takeNow)
    }
}
