//
//  ContentFailureServie.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Foundation

final class ContentFailureStub: ContentServiceProtocol {
    func postVideos(_ videoURLs: [VideoURL]) async -> Result<ServiceResponse<ContentDTO>, ServiceError> {
        .failure(.MOCK())
    }
    
    func postPhotos(_ data: [Data]) async -> Result<ServiceResponse<ContentDTO>, ServiceError> {
        .failure(.MOCK())
    }
}
