//
//  ContentImage.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

struct ImageContent: Identifiable, Codable, Hashable {
    let id: String = UUID().uuidString
    let stepPhotoID: Int
    let photoURL: String
    
    static let MOCK_DATA1: ImageContent = ImageContent(stepPhotoID: 1, photoURL: "https://picsum.photos/seed/picsum/200/300")
    static let MOCK_DATA2: ImageContent = ImageContent(stepPhotoID: 2, photoURL: "https://picsum.photos/200/300/?blur")
    static let MOCK_DATA3: ImageContent = ImageContent(stepPhotoID: 3, photoURL: "https://picsum.photos/seed/picsum/200/300")

      enum CodingKeys: String, CodingKey {
          case stepPhotoID = "stepPhotoId"
          case photoURL = "photoUrl"
      }
}
