//
//  BaseResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/27.
//

import Foundation

struct AccountCheckResponse: Codable {
    let message: String
    let status: Int
    let data: Data
    
    static let MOCK_DATA_UNIQUE: Data = Data(isUnique: true)
    static let MOCK_DATA_NOT_UNIQUE: Data = Data(isUnique: false)
    
    struct Data: Codable {
        let isUnique: Bool
    }

}
