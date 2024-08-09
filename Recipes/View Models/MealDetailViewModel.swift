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
    @Published var isLoading = false
       @Published var showingError = false
       @Published var errorMessage: String?
    
    
    func fetchMealDetail(id: String) {
            isLoading = true
            showingError = false
            Task {
                do {
                    mealDetail = try await APIService.shared.fetchMealDetail(id: id)
                } catch {
                    showingError = true
                    errorMessage = error.localizedDescription
                }
                isLoading = false
            }
        }
}
