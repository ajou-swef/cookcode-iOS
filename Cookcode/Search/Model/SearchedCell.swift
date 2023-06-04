//
//  Cell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

protocol SearchedCell: Cell {
    var userName: String { get set }
    var createdAt: String { get set }
}
