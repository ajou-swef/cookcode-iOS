//
//  ContentType.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/22.
//

import Foundation
import PhotosUI

enum ContentType {
    case video
    case image
    
    var phpFilter: PHPickerFilter {
        switch self {
        case .video:
            return .videos
        case .image:
            return .images
        }
    }
    
    var maxSelection: Int {
        switch self {
        case .video:
            return 2
        case .image:
            return 3
        }
    }
}
