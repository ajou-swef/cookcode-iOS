//
//  CookieFailureServcie.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/09.
//

import Alamofire
import Foundation
 
final class CookieFailureService: CookieServiceProtocol {
    func getCookieByCookieId(_ id: Int) async -> Result<ServiceResponse<CookieDetailDTO>, ServiceError> {
        .failure(.MOCK())
    }
    
    func patchCookie(id: Int, cookieForm: CookieForm) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func deleteCookie(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func likesCookie(_ cookie: CookieDetail) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func postCookie(cookie: CookieForm, closure: @escaping (Progress) -> (Void)) async -> Result<DefaultResponse, ServiceError> {
        do {
            try await Task.sleep(nanoseconds: 3000000000)
            return .failure(.MOCK())
        } catch {
            return .failure(.MOCK())
        }
    }
    
    func getCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError> {
        .failure(.MOCK())
    }
    
    func getCookieCellByUserId(_ id: Int, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func getCookieCellsByQuery(_ query: String, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<PageResponse<CommentDTO>>, ServiceError> {
        .failure(.MOCK())
    }
    
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.MOCK())
    }
    
    
}
