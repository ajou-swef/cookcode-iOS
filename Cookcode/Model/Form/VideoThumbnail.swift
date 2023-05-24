//
//  VideoThumbnail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import Foundation
import SwiftUI

struct VideoThumbnail: Identifiable {
    let id: String = UUID().uuidString
    var url: URL
    var loadState: VideoLoadState
}
