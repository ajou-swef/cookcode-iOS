//
//  FetchCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

protocol SearchCellServiceProtocol {
    func searchCell(page: Int, size: Int, sort: String?, month: Int?) async -> Result<[any SearchedCell], ServiceError>
}
