//
//  Cell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

protocol Cell: Mock {
    var thumbnail: String { get set }
    var title: String { get set }
    var userNmae: String { get set }
}
