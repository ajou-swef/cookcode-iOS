//
//  StepDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct StepDTO: Codable, Mock, Hashable {
    static func mock() -> StepDTO {
        StepDTO(stepID: 1, seq: 1, title: "title", description: "description", photos: PhotoDTO.mocks(1), videos: VideoDTO.mocks(1))
    }
    
    let stepID, seq: Int
    let title, description: String
    let photos: [PhotoDTO]
    let videos: [VideoDTO]
    
    var photosIsEmpty: Bool {
        photos.isEmpty
    }
    
    var contentURLs: [String] {
        if !photosIsEmpty {
            return photos.map { $0.photoURL }
        }
        return videos.map { $0.videoURL }
    }


    enum CodingKeys: String, CodingKey {
        case stepID = "stepId"
        case seq, title, description, photos, videos
    }
}
