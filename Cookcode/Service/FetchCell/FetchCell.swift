//
//  FetchCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

protocol FetchCell {
    func fetchCell(page: Int, size: Int, sort: String, month: Int) async -> Result<[any Cell], ServiceError>
}
