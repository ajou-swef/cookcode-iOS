//
//  CookieForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Foundation

struct CookieForm {
    var videoURL: URL?
    var description: String = ""
    var title: String = ""
    var thumbnailData: Data? 
}

extension CookieForm {
    init(detail: CookieDetail) {
        self.title = detail.title
        self.description = detail.description
    }
}
