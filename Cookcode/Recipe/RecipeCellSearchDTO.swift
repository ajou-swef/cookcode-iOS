//
//  RecipeCellSearch.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeCellSearchDTO: Codable, Mock {
    static func mock() -> RecipeCellSearchDTO {
        RecipeCellSearchDTO(recipeCells: .mock(), numberOfElements: 1, hasNext: false)
    }
    
    var recipeCells: [RecipeCellDto]
    var numberOfElements: Int
    var hasNext: Bool
    
    
    enum CodingKeys: String, CodingKey {
        case recipeCells = "content"
        case numberOfElements
        case hasNext
    }
}

//extension RecipeCellSearchDTO {
//    init (recipeCells: [RecipeCellDto], numberOfElements: Int, offset: Int, pageNumber: Int, pageSize: Int, totalElements: Int, totalPages: Int) {
//        self.recipeCells = recipeCells
//        self.numberOfElements = numberOfElements
//        self.offset = offset
//        self.pageNumber = pageNumber
//        self.pageSize = pageSize
//        self.totalElements = totalElements
//        self.totalPage = totalPages
//    }
//}
