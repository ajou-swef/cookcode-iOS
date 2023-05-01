//
//  ContentSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

final class ContentFinalService: ContentServiceProtocol {
    func postPhotos(_ data: [Data]) async -> Result<PhotoResponse, ServiceError> {
        .success(PhotoResponse(message: "post성공", status: 200, data: PhotoURL.MOCK_DATA()))
    }
    
    func postVideos(_ data: [Data]) async -> Result<VideoResponse, ServiceError> {
        .success(VideoResponse(message: "vide post 성공", status: 200, data: VideoDataURL.MOCK_DATA()))
    }
    
    
}
