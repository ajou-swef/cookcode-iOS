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
    
    var isUnique: Bool {
        data.isUnique
    }
    
    static let MOCK_DATA: Data = Data(isUnique: ([false, true].randomElement()!))
    
    struct Data: Codable {
        let isUnique: Bool
    }

}
