//
//  IngredientCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

// MARK: - DataClass
struct IngredientCellDto: Codable {
    let ingredID: Int
    let name, expiredAt, category, quantity: String
    
    static func MOCK() -> IngredientCellDto {
        IngredientCellDto(ingredID: 1, name: "양배추", expiredAt: "2023-08-31", category: "채소", quantity: "3Kg")
    }

    enum CodingKeys: String, CodingKey {
        case ingredID = "ingredId"
        case name, expiredAt, category, quantity
    }
}
