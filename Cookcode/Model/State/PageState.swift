//
//  PageState.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

enum PageState {
    case loading(Int)
    case wait(Int)
    
    var isWaitingState: Bool {
        switch self {
        case .loading(_):
            return false
        case .wait(_):
            return true
        }
    }
    
    var page: Int {
        switch self {
        case .loading(let int):
            return int
        case .wait(let int):
            return int
        }
    }
}
