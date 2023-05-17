//
//  ContentService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Alamofire
import Foundation
import UIKit

final class ContentService: ContentServiceProtocol {
    
    func postPhotos(_ data: [Data]) async -> Result<ServiceResponse<ContentDTO>, ServiceError> {
        let url = "\(BASE_URL)/api/v1/recipe/files"
        
        let headers: HTTPHeaders = [
            ACCESS_TOKEN_KEY : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? ""
        ]
        
        var imageDatas: [Data] = []
        for data in data {
            imageDatas.append(data)
        }
        
        let response = await AF.upload(multipartFormData: { multipart in
            for imageData in imageDatas {
                multipart.append(imageData, withName: "stepFiles", fileName: UUID().uuidString, mimeType: "image/jpeg")
            }
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers).serializingDecodable(ServiceResponse<ContentDTO>.self).response
        
        print("\(response.debugDescription)")
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    
    }
    
    func postVideos(_ videoURL: VideoURL) async -> Result<VideoResponse, ServiceError> {
        let url = "\(BASE_URL)"
        
        let headers: HTTPHeaders = [
            "accessToken" : UserDefaults.standard.string(forKey: ACCESS_TOKEN_KEY) ?? "",
        ]
        
        let response = await AF.upload(multipartFormData: { multipart in
            multipart.append(videoURL.url, withName: "name")
        }, to: url, method: .post, headers: headers).serializingDecodable(VideoResponse.self).response
        
        return response.result.mapError { err in
            let serviceErorr = response.data.flatMap { try? JSONDecoder().decode(ServiceError.self, from: $0) }
            return serviceErorr ?? ServiceError.MOCK()
        }
    
    }
    
    
}
