//
//  CommentServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/29.
//

import Foundation

protocol CommentServiceProtocol {
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<PageResponse<CommentDTO>>, ServiceError>
    
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError>
    
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> 
    
}
