//
//  ContentSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

final class ContentSuccessService: ContentServiceProtocol {
    func postVideos(_ videoURL: VideoURL) async -> Result<VideoResponse, ServiceError> {
        .success(VideoResponse(message: "", status: 1, data: VideoDataURL.MOCK_DATA()))
    }
    
    func postPhotos(_ data: [Data]) async -> Result<ServiceResponse<ContentDTO>, ServiceError> {
        .success(.mock())
    }
}
