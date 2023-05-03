//
//  NetworkError.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Alamofire
import Foundation

struct NetworkError: Error {
    let alamofireError: AFError?
    let serviceError: ServiceError? 
}

struct ServiceError: Codable, Error {
    let message: String
    let status: Int
    
    static func MOCK() -> ServiceError {
        ServiceError(message: "실패", status: 400)
    }
}
