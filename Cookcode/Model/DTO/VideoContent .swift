//
//  VideoContent .swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct VideoContent: Codable {
    let stepVideoID: Int
    let videoURL: String
    
    static let MOCK_DATA: VideoContent = VideoContent(stepVideoID: 1, videoURL:  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")

    enum CodingKeys: String, CodingKey {
        case stepVideoID = "stepVideoId"
        case videoURL = "videoUrl"
    }
}
