//
//  RecipeFilterType.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/15.
//

import Foundation

enum RecipeFilterType: String, CaseIterable {
    case all = "전체 보기"
    case cookable = "cookable"
    
    var cookable: Bool {
        switch self {
        case .all:
            return false
        case .cookable:
            return true
        }
    }
}
