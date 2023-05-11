//
//  VideoDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation


struct VideoDTO: Codable, Mock, Hashable {
    static func mock() -> VideoDTO {
        VideoDTO(stepVideoID: 1, videoURL: "")
    }
    
    let stepVideoID: Int
    let videoURL: String
    
    

    enum CodingKeys: String, CodingKey {
        case stepVideoID = "stepVideoId"
        case videoURL = "videoUrl"
    }
}
