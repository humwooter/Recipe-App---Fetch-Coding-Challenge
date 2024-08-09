//
//  APIService.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation


struct MealListResponse: Decodable { let meals: [Meal] }

struct MealDetailResponse: Decodable { let meals: [MealDetail] }


class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchMeals() async throws -> [Meal] {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MealListResponse.self, from: data).meals.sorted { $0.name < $1.name }
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetail {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MealDetailResponse.self, from: data).meals.first!
    }
}


