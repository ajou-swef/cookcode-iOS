//
//  Content.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Alamofire
import Foundation
import cookcode_service

protocol ContentServiceProtocol {
    func postPhotos(_ data: [Data]) async -> Result<ServiceResponse<ContentDTO>, ServiceError>
    func postVideos(_ videoURLs: [VideoURL]) async -> Result<ServiceResponse<ContentDTO>, ServiceError>
}
