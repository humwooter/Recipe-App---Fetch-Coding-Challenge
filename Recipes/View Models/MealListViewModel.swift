//
//  MealListViewModel.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation



@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String?
    
    func fetchMeals() {
        Task {
            do {
                meals = try await APIService.shared.fetchMeals()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
