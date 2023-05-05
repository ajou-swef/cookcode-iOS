//
//  IngredientCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

// MARK: - DataClass
struct IngredientCellDto: Codable, Mock {
    
    let fridgeIngredId, ingredId: Int
    let quantity: Int
    let name, expiredAt, category: String
    
    static func Mock() -> IngredientCellDto {
        return IngredientCellDto(fridgeIngredId: Int.random(in: 0..<1000), ingredId: 1, quantity: 10, name: "양배추", expiredAt: "2023-08-31", category: "채소")
    }

    enum CodingKeys: String, CodingKey {
        case fridgeIngredId, ingredId
        case name, expiredAt, category, quantity
    }
}
