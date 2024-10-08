//
//  ContentView.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var searchModel = SearchModel()
    @StateObject var networkMonitor = NetworkMonitor()

    
    var body: some View {
        MealListView()
            .environmentObject(searchModel)
            .environmentObject(networkMonitor)
            .searchable(text: $searchModel.searchText)
    }
}

#Preview {
    ContentView()
}
