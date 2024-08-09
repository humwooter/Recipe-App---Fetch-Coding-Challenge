//
//  MealDetail.swift
//  Recipes
//
//  Created by Katyayani G. Raman on 8/8/24.
//

import Foundation


struct MealDetail: Identifiable, Decodable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String]
    let measurements: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        let containerDict = try decoder.container(keyedBy: DynamicCodingKeys.self)
        ingredients = (1...20).compactMap { index in
            guard let key = DynamicCodingKeys(stringValue: "strIngredient\(index)") else { return nil }
            return try? containerDict.decodeIfPresent(String.self, forKey: key)
        }.compactMap { $0 }.filter { !$0.isEmpty }
        
        measurements = (1...20).compactMap { index in
            guard let key = DynamicCodingKeys(stringValue: "strMeasure\(index)") else { return nil }
            return try? containerDict.decodeIfPresent(String.self, forKey: key)
        }.compactMap { $0 }.filter { !$0.isEmpty }
    }
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }
        var intValue: Int? { nil }
        init?(intValue: Int) { return nil }
    }
}
