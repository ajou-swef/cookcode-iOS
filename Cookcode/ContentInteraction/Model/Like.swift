//
//  Like.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import Foundation

protocol Like: Identifiable {
    var id: String { get set }
    var isLiked: Bool { get set }
    var likesCount: Int { get set }
}

extension Like {
    mutating func likeInteract() {
        if isLiked {
            likesCount -= 1
        } else {
            likesCount += 1
        }
        
        isLiked.toggle()
    }
}
