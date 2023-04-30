//
//  RecipeStep.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct RecipeStep: Codable {
    let stepID, seq: Int
    let title, description: String
    let photos: [ImageContent]
    let videos: [VideoContent]
    
    static let MOCK_DATA: RecipeStep = RecipeStep(stepID: 1, seq: 1, title: "레시피", description: "설명", photos: [ImageContent.MOCK_DATA, ImageContent.MOCK_DATA, ImageContent.MOCK_DATA], videos: [])

    enum CodingKeys: String, CodingKey {
        case stepID = "stepId"
        case seq, title, description, photos, videos
    }
}
