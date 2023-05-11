//
//  PhotoDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct PhotoDTO: Codable, Mock, Hashable {
    static func mock() -> PhotoDTO {
        PhotoDTO(stepPhotoID: 1, photoURL: "")
    }
    
    let stepPhotoID: Int
    let photoURL: String

    enum CodingKeys: String, CodingKey {
        case stepPhotoID = "stepPhotoId"
        case photoURL = "photoUrl"
    }
}
