//
//  ServiceResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/07.
//

import Foundation

struct ServiceResponse<T: Codable & Mock>: Codable  {
    
    let message: String
    let status: Int
    let data: T
    
    static func mock() -> ServiceResponse<T> {
        ServiceResponse(message: "응답 성공", status: 200, data: T.mock())
    }
}
