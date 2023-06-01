////
////  RecipeStep.swift
////  Cookcode
////
////  Created by 노우영 on 2023/04/30.
////
//
//import Foundation
//
//struct RecipeStepDTO: Codable, Hashable, Identifiable {
//    let id = UUID().uuidString
//    let stepID, seq: Int
//    let title, description: String
//    let photos: [ImageContent]
//    let videos: [VideoContent]
//
//    var photosIsEmpty: Bool {
//        photos.isEmpty
//    }
//
//    var videosIsEmpty: Bool {
//        videos.isEmpty
//    }
//
//    var contentURLs: [String] {
//        if !photosIsEmpty {
//            return photos.map { $0.photoURL }
//        }
//        return videos.map { $0.videoURL }
//    }
//
//    static let MOCK_DATA: RecipeStepDTO = RecipeStepDTO(stepID: 1, seq: 1, title: "레시피", description: "설명", photos: [ImageContent.MOCK_DATA1, ImageContent.MOCK_DATA2], videos: [])
//
//    static let MOCK_DATA2: RecipeStepDTO = RecipeStepDTO(stepID: 2, seq: 1, title: "레시피", description: "설명", photos: [ImageContent.MOCK_DATA3], videos: [])
//
//
//    enum CodingKeys: String, CodingKey {
//        case stepID = "stepId"
//        case seq, title, description, photos, videos
//    }
//}
