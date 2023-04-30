//
//  RecipeCellSearchResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeCellSeachResponse: Codable {
    let message: String
    let status: Int
    let content: [RecipeCellSearch]
    
    static let MOCK_DATA: RecipeCellSeachResponse = RecipeCellSeachResponse(message: "검색성공", status: 200, content: [RecipeCellSearch.MOCK_DATA, RecipeCellSearch.MOCK_DATA, RecipeCellSearch.MOCK_DATA])
}
