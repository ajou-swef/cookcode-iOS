//
//  CookieDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import Foundation
import AVKit


struct CookieDetail: Like, CommentButtonInfo {
    var id: String = UUID().uuidString
    var url: String
    var title: String
    var contentId: Int
    var thumbnail: String
    var description: String
    var likesCount: Int
    var commentsCount: Int
    var isLiked: Bool = false
    var avPlayer: AVPlayer?
    
    mutating func onAppear() {
        guard let url = URL(string: url) else { return }
        avPlayer = AVPlayer(url: url)
        avPlayer?.play()
    }
    
    mutating func onDisapper() {
        avPlayer = nil
    }
    
    
    mutating func update(cookie: CookieDetail) {
        url = cookie.url
        title = cookie.title
        contentId = cookie.contentId
        description = cookie.description
        likesCount = cookie.likesCount
        commentsCount = cookie.commentsCount
        isLiked = cookie.isLiked
    }
    
    static func mock() -> CookieDetail {
        CookieDetail(dto: .mock())
    }
}

extension CookieDetail {
    init(dto: CookieDetailDTO) {
        url = dto.videoURL
        title = dto.title
        contentId = dto.cookieID
        thumbnail = dto.thumbnailURL
        description = dto.desc
        likesCount = dto.likeCount
        commentsCount = dto.commentCount
        isLiked = dto.isLiked == 0 ? false : true
    }
}
