//
//  SearchModel.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation


class SearchModel: ObservableObject {
    @Published var searchText: String = "" {
        didSet {
            print("Search Text: \(searchText)")
        }
    }
}


