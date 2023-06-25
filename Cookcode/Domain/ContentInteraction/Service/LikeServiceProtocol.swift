//
//  LikeServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import Foundation

protocol LikeServiceProtocol {
    func likesContentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> 
}
