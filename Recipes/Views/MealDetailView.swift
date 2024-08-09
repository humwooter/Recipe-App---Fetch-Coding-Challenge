//
//  MealDetailView.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = MealDetailViewModel()
    let mealId: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let meal = viewModel.mealDetail {
                    Text(meal.name)
                        .font(.title)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(.headline)
                        ForEach(Array(zip(meal.ingredients.indices, zip(meal.ingredients, meal.measurements))), id: \.0) { index, pair in
                            let (ingredient, measurement) = pair
                            Text("\(index + 1). \(ingredient): \(measurement)")
                        }
                    }
                    .padding()
                    .background(getBackgroundColor())
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions:")
                            .font(.headline)
                        Text(meal.instructions)
                    }
                    .padding()
                    .background(getBackgroundColor())
                    .clipShape(RoundedRectangle(cornerRadius: 10))

             
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .onAppear { viewModel.fetchMealDetail(id: mealId) }
        .alert("Error", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Text(viewModel.errorMessage ?? "")
        }
    }

    func getBackgroundColor() -> Color {
            return Color(UIColor.secondarySystemBackground)
    }
}

