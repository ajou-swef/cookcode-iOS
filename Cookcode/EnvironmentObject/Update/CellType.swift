//
//  CellType.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/22.
//

import Foundation

enum CellType: CaseIterable {
    case recipe
    case cookie
    case ingredient
}

enum UpdateType {
    case delete
    case patch
}

struct CellUpdateInfo {
    let updateType: UpdateType
    let cellId: Int
}
