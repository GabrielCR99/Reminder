//
//  MyRecipesViewModel.swift
//  Reminder
//
//  Created by Gabriel Roveri on 07/05/25.
//

final class MyRecipesViewModel {
    func fetchData() -> [Medicine] {
        DBHelper.shared.fetchRecipes()
    }
    
    func deleteRecipeById(_ id: Int) {
        DBHelper.shared.deleteRecipeById(id)
    }
}
