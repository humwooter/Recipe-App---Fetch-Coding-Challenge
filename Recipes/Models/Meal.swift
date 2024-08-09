//
//  Meal.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnailURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}
