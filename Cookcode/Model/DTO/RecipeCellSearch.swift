//
//  RecipeCellSearch.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeCellSearch: Codable {
    var recipeCells: [RecipeCellDto]
    var numberOfElements, offset, pageNumber, pageSize: Int
    var totalElements, totalPages: Int
    
    static let MOCK_DATA: RecipeCellSearch = RecipeCellSearch(recipeCells: [RecipeCellDto.MOCK_DATA, RecipeCellDto.MOCK_DATA], numberOfElements: 0, offset: 0, pageNumber: 0, pageSize: 0, totalElements: 0, totalPages: 0)
    
    enum CodingKeys: String, CodingKey {
        case recipeCells = "content"
        case numberOfElements, offset, pageNumber, pageSize
        case totalElements, totalPages
    }
    
    init () {
        recipeCells = .init()
        numberOfElements = 0
        offset = 0
        pageNumber = 0
        pageSize = 0
        totalElements = 0
        totalPages = 0
    }
    
    init (recipeCells: [RecipeCellDto], numberOfElements: Int, offset: Int, pageNumber: Int, pageSize: Int, totalElements: Int, totalPages: Int) {
        self.recipeCells = recipeCells
        self.numberOfElements = numberOfElements
        self.offset = offset
        self.pageNumber = pageNumber
        self.pageSize = pageSize
        self.totalElements = totalElements
        self.totalPages = totalPages
    }
    
    mutating func update(_ newSearchResult: RecipeCellSearch) {
        recipeCells.append(contentsOf: newSearchResult.recipeCells)
        numberOfElements = newSearchResult.numberOfElements
        offset = newSearchResult.offset
        pageNumber = newSearchResult.pageNumber
        pageSize = newSearchResult.pageSize
        totalElements = newSearchResult.totalElements
        totalPages += newSearchResult.totalPages
    }
}
