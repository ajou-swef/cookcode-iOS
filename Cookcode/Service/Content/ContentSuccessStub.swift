//
//  ContentSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import cookcode_service
import Foundation

final class ContentSuccessStub: ContentServiceProtocol {
    func postVideos(_ videoURLs: [VideoURL]) async -> Result<ServiceResponse<ContentDTO>, ServiceError> {
        .success(.mock())
    }
    
    func postPhotos(_ data: [Data]) async -> Result<ServiceResponse<ContentDTO>, ServiceError> {
        .success(.mock())
    }
}
