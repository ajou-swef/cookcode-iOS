//
//  Recipe.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeCell: Codable, Hashable {
    let recipeID: Int
    let user: User
    let title, description, createdAt, updatedAt: String
    let isLiked: Bool
    let likeCount, commentCount: Int
    let isCookable: Bool
    let thumbanil: String
    let steps: [RecipeStep]
    
    static let MOCK_DATA: RecipeCell = RecipeCell(recipeID: 1, user: User.MOCK_DATA, title: "레시피 제목", description: "레시피 설명", createdAt: "3131", updatedAt: "213131", isLiked: false, likeCount: 10, commentCount: 30, isCookable: true, thumbanil: "https://picsum.photos/id/870/200/300?grayscale&blur=2", steps: [RecipeStep.MOCK_DATA, RecipeStep.MOCK_DATA])

    enum CodingKeys: String, CodingKey {
        case recipeID = "recipeId"
        case user, title, description, createdAt, updatedAt, isLiked, likeCount, commentCount, isCookable, thumbanil, steps
    }
}
