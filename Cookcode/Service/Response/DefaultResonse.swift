//
//  DefaultResonse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Foundation

struct DefaultResponse: Codable  {
    
    let message: String
    let status: Int
    
    static func mock() -> DefaultResponse {
        DefaultResponse(message: "성공", status: 200)
    }
}
