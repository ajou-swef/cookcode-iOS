//
//  ContentFailureServie.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

final class ContentFailureService: ContentServiceProtocol {
    func postVideos(_ videoURL: VideoURL) async -> Result<VideoResponse, ServiceError> {
        .failure(ServiceError.MOCK())
    }
    
    func postPhotos(_ data: [Data]) async -> Result<PhotoResponse, ServiceError> {
        .failure(ServiceError.MOCK())
    }
}
