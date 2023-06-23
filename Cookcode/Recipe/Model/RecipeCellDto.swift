//
//  Recipe.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeCellDto: Decodable, Hashable, Mock {
    
    static var createdMockCount: Int = 0
    
    static func mock() -> RecipeCellDto {
        createdMockCount += 1
        return RecipeCellDto(recipeID: createdMockCount, user: UserCellDto.mock(), title: "title", description: "description", createdAt: "2023-12-12", updatedAt: "2023-12-14", thumbnail: "https://picsum.photos/800/200", likeCount: 1, isCookable: Bool.random())
    }
    
    let recipeID: Int
     let user: UserCellDto
     let title, description: String
     let createdAt, updatedAt, thumbnail: String
    let likeCount: Int
    let isCookable: Bool

     enum CodingKeys: String, CodingKey {
         case recipeID = "recipeId"
         case user, title, description, createdAt, updatedAt, thumbnail
         case likeCount, isCookable
     }
}
