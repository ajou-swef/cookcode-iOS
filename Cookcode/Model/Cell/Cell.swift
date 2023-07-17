//
//  Cell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import Foundation
import cookcode_service

protocol Cell: Identifiable, Hashable, Mock {
    var id: String { get set }
    var thumbnail: String { get set }
    var title: String { get set }
}
