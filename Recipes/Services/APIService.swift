//
//  APIService.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation


struct MealListResponse: Decodable { let meals: [Meal] }

struct MealDetailResponse: Decodable { let meals: [MealDetail] }

// singleton api service for fetching meal data
class APIService {
    static let shared = APIService() // shared instance
    private init() {}
    
    //fetch meal list
    func fetchMeals() async throws -> [Meal] {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        return try JSONDecoder().decode(MealListResponse.self, from: data).meals.sorted { $0.name < $1.name }
    }
    
    // fetch detailed information for a specific meal by id
    func fetchMealDetail(id: String) async throws -> MealDetail {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        return try JSONDecoder().decode(MealDetailResponse.self, from: data).meals.first!
    }
    
    private func createURLSession(timeout: TimeInterval = 10) -> URLSession {
         let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = timeout
         configuration.timeoutIntervalForResource = timeout
         return URLSession(configuration: configuration)
     }
}


