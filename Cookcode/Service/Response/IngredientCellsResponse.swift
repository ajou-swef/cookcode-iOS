//
//  IngredientCellsResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

struct IngredientCellsResponse: Codable {
    let message: String
    let status: Int
    let data: [IngredientCell]
    
    static func MOCK() -> IngredientCellsResponse {
        IngredientCellsResponse(message: "조회 성공", status: 200, data: [IngredientCell.MOCK(), IngredientCell.MOCK(), IngredientCell.MOCK()])
    }
}