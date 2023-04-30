//
//  ContentImage.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct ImageContent: Codable {
    let stepPhotoID: Int
    let photoURL: String
    
    static let MOCK_DATA: ImageContent = ImageContent(stepPhotoID: 1, photoURL: "https://picsum.photos/seed/picsum/200/300")

      enum CodingKeys: String, CodingKey {
          case stepPhotoID = "stepPhotoId"
          case photoURL = "photoUrl"
      }
}
