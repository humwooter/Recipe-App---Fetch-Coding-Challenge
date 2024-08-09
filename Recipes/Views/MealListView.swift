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
    
    @State private var showingError = false


    var body: some View {
           NavigationView {
               Group {
                   if viewModel.meals.isEmpty {
                       if viewModel.isLoading {
                           ProgressView("Loading desserts...")
                       } else {
                           VStack {
                               Text("No desserts available")
                                   .foregroundColor(.secondary)
                               Text("Pull to refresh")
                                   .font(.caption)
                                   .foregroundColor(.secondary)
                           }
                       }
                   } else {
                       filteredMealsView()
                   }
               }
               .navigationTitle("Desserts")
               .refreshable {
                   await viewModel.fetchMeals()
               }
               .onAppear {
                   if viewModel.meals.isEmpty {
                       Task {
                           await viewModel.fetchMeals()
                       }
                   }
               }
           }
           .alert(isPresented: $showingError) {
               Alert(
                   title: Text("Error"),
                   message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                   dismissButton: .default(Text("OK"))
               )
           }
       }
    
    @ViewBuilder
    func mealListView(meals: [Meal]) -> some View {
        List(meals) { meal in
            NavigationLink {
                VStack {
                    MealDetailView(mealId: meal.id, mealThumbnail: meal.thumbnailURL)
                }
            } label: {
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
