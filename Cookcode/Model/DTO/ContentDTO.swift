//
//  ContentDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/16.
//

import Foundation

struct ContentDTO: Codable, Mock {
    static func mock() -> ContentDTO {
        ContentDTO(urls: ["https://cookcode-swef-s3.s3.ap-northeast-2.amazonaws.com/recipe/%E1%84%83%E1%85%A1%E1%86%BC%E1%84%80%E1%85%B3%E1%86%AB%E1%84%86%E1%85%A1%E1%84%8F%E1%85%A6%E1%86%BA.png"])
    }
    
    let urls: [String]
}
