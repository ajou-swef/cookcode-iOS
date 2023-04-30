//
//  RecipeCellSearch.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeCellSearch: Codable {
    let content: [RecipeCell]
    let numberOfElements, offset, pageNumber, pageSize: Int
    let totalElements, totalPages: Int
    
    static let MOCK_DATA: RecipeCellSearch = [RecipeCell.MOCK_DATA, RecipeCell.MOCK_DATA, RecipeCell.MOCK_DATA]
}
