//
//  MealDetailViewModel.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var errorMessage: String?
    
    func fetchMealDetail(id: String) {
        Task {
            do {
                mealDetail = try await APIService.shared.fetchMealDetail(id: id)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
