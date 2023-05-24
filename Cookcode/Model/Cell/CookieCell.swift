//
//  CookieCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import Foundation

struct CookieCell: SearchedCell {
    var id: String = UUID().uuidString
    
    var thumbnail: String
    var cookieId: Int
    var title: String
    var createdAt: String
    var userName: String
    
    static func mock() -> CookieCell {
        CookieCell(thumbnail: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                   cookieId: 1, title: "쿠키", createdAt: "2023-03-31", userName: "유저이름")
    }
    
    
}
