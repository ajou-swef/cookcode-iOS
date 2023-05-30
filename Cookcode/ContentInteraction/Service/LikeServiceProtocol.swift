//
//  LikeServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/30.
//

import SwiftUI

protocol LikeServiceProtocol {
    func likesContentById(_ contentId: Int) async -> Result<DefaultResponse, ServiceError> 
}
