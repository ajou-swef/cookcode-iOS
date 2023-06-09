//
//  CookieSuccessService.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation

final class CookieSuccessService: CookieServiceProtocol {
    func fetchCookieCellByUserId(_ id: Int, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> {
        .success(.mock())
    }
    
    func likesCookie(_ cookie: CookieDetail) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func searchCookieCellsBy(_ query: String) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> {
        .success(.mock())
    }
    
    func postCookie(cookie: CookieForm, closure: @escaping (Progress) -> (Void)) async -> Result<DefaultResponse, ServiceError> {
        .success(.mock())
    }
    
    func fetchCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError> {
        .success(.mock())
    }
    
    func fetchCookieCellByUserId(_ id: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> {
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
