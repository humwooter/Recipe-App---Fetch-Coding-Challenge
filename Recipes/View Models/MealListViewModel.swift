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
    
    @Published var isLoading = false

    
    func fetchMeals() {
        Task {
            isLoading = true
            do {
                meals = try await APIService.shared.fetchMeals()
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
