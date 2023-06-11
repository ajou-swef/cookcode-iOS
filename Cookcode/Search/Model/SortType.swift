//
//  SortType.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

enum SortType: String, CaseIterable {
    case latest = "createdAt"
    case popularity = "popular"
    
    var text: String {
        switch self {
        case .latest:
            return "최신순"
        case .popularity:
            return "인기순"
        }
    }
}
