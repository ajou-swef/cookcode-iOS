//
//  PageState.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

enum PageState: Equatable {
    case loading(Int)
    case wait(Int)
    case noRemain
    
    var isNoRemain: Bool {
        switch self {
        case .noRemain:
            return true
        default:
            return false 
        }
    }
    
    var isLoadingState: Bool {
        switch self {
        case .loading(_):
            return true
        default:
            return false
        }
    }
    
    var isWaitingState: Bool {
        switch self {
        case .wait(_):
            return true
        default:
            return false
            
        }
    }
    
    var page: Int {
        switch self {
        case .loading(let int):
            return int
        case .wait(let int):
            return int
        case .noRemain:
            return -1 
        }
    }
}
