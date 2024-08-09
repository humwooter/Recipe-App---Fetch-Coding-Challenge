//
//  MealListView.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation
import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    @EnvironmentObject var searchModel: SearchModel
    @Environment(\.isSearching) private var isSearching

    var body: some View {
        NavigationView {
            filteredMealsView()
            .navigationTitle("Desserts")
            .onAppear { viewModel.fetchMeals() }
        }
        .alert("Error", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Text(viewModel.errorMessage ?? "")
        }
    }
    @ViewBuilder
    func mealListView(meals: [Meal]) -> some View {
        List(meals) { meal in
            NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                Text(meal.name)
            }.padding()
        }
    }
    
    @ViewBuilder
    func filteredMealsView() -> some View {
        if searchModel.searchText.isEmpty {
            mealListView(meals: viewModel.meals)
        } else {
            mealListView(meals: viewModel.meals.filter {$0.name.lowercased().contains(searchModel.searchText.lowercased())})
        }
    }
    
}
