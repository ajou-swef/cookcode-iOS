//
//  CookieSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation

final class CookieSuccessService: CookieServiceProtocol {
    func postCookie(cookie: CookieForm) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func fetchCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError> {
        .success(.mock())
    }
    
    func fetchCookieCellByUserId(_ id: Int) async -> Result<ServiceResponse<PageResponse<CookieCellDto>>, ServiceError> {
        .success(.mock())
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<PageResponse<CommentDTO>>, ServiceError> {
        .success(.mock())
    }
    
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    
}
