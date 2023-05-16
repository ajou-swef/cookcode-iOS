//
//  Content.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import Alamofire
import Foundation

protocol ContentServiceProtocol {
    func postPhotos(_ data: [Data]) async -> Result<ServiceResponse<ContentDTO>, ServiceError>
    func postVideos(_ videoURL: VideoURL) async -> Result<VideoResponse, ServiceError>
}
