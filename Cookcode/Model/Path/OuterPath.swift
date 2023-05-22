//
//  OuterPath.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import Foundation

enum OuterPath: String {
    case recipe
    case profile
    case cookie
}

struct OuterIdPath: Equatable {
    let path: OuterPath
    let id: Int?
}
