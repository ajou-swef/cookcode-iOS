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
    let data: RecipeCellSearch
    
    static let MOCK_DATA: RecipeCellSeachResponse = RecipeCellSeachResponse(message: "검색성공", status: 200, data: RecipeCellSearch.MOCK_DATA)
}