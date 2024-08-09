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
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false

    @Environment(\.isSearching) private var isSearching

    var body: some View {
        NavigationView {
            Group {
                if viewModel.meals.isEmpty || !networkMonitor.hasConnection {
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
                } else if !viewModel.showingError {
                    filteredMealsView()
                }
            }
            .navigationTitle("Desserts")
       
            .onAppear {
                if viewModel.meals.isEmpty {
                    Task {
                        viewModel.fetchMeals()
                    }
                }
            }
        }
        .refreshable {
            if networkMonitor.hasConnection {
                viewModel.fetchMeals()
            }
        }
        .onChange(of: networkMonitor.hasConnection) {
            showNetworkAlert = !networkMonitor.hasConnection
        }
        .alert(
            "Network connection seems to be offline.",
            isPresented: $showNetworkAlert
        ) {}

        .alert(isPresented: $viewModel.showingError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                dismissButton: .default(Text("OK"), action: {
                    Task {
                        viewModel.fetchMeals()
                    }
                })
            )
        }
    }

    @ViewBuilder
    func mealListView(meals: [Meal]) -> some View {
        List(meals) { meal in
            NavigationLink {
                VStack {
                    MealDetailView(mealId: meal.id, mealThumbnail: meal.thumbnailURL)
                        .environmentObject(networkMonitor)
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
            mealListView(meals: viewModel.meals.filter { $0.name.lowercased().contains(searchModel.searchText.lowercased()) })
        }
    }
}
