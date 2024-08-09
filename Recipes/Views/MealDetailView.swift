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
    var mealThumbnail: URL?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let meal = viewModel.mealDetail {
                    Text(meal.name)
                        .font(.title)
                    
                    MealThumbnailView(thumbnailURL: mealThumbnail)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(.headline)
                        
                        let ingredientsText = meal.ingredients.enumerated().map { index, ingredient in
                            "\(index + 1). \(ingredient): \(meal.measurements[index])"
                        }.joined(separator: "\n")
                        
                        Text(ingredientsText)
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = ingredientsText
                                }) {
                                    Text("Copy Ingredients")
                                    Image(systemName: "doc.on.clipboard")
                                }
                            }
                    }
                    .padding()
                    .background(getBackgroundColor())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions:")
                            .font(.headline)
                        
                        Text(meal.instructions)
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = meal.instructions
                                }) {
                                    Text("Copy Instructions")
                                    Image(systemName: "doc.on.clipboard")
                                }
                            }
                    }
                    .padding()
                    .background(getBackgroundColor())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)

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
                   Text(viewModel.errorMessage ?? "An unknown error occurred")
                   Button("Dismiss", role: .cancel) {
                       viewModel.errorMessage = nil
                   }
               }
        
    }

    func getBackgroundColor() -> Color {
        return Color(UIColor.secondarySystemBackground)
    }
}
