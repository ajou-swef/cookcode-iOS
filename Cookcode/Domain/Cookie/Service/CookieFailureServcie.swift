//
//  CookieFailureServcie.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/09.
//

import Alamofire
import cookcode_service
import Foundation
 
final class CookieFailureStub: CookieServiceProtocol {
    func getCookieByCookieId(_ id: Int) async -> Result<ServiceResponse<CookieDetailDTO>, ServiceError> {
        .failure(.mock())
    }
    
    func patchCookie(id: Int, cookieForm: CookieForm) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func deleteCookie(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func likesCookie(_ cookie: CookieDetail) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func postCookie(cookie: CookieForm, closure: @escaping (Progress) -> (Void)) async -> Result<DefaultResponse, ServiceError> {
        do {
            try await Task.sleep(nanoseconds: 3000000000)
            return .failure(.mock())
        } catch {
            return .failure(.mock())
        }
    }
    
    func getCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError> {
        .failure(.mock())
    }
    
    func getCookieCellByUserId(_ id: Int, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> {
        .failure(.mock())
    }
    
    func getCookieCellsByQuery(_ query: String, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> {
        .failure(.mock())
    }
    
    func fetchCommentsById(_ id: Int) async -> Result<ServiceResponse<PageResponse<CommentDTO>>, ServiceError> {
        .failure(.mock())
    }
    
    func postCommentWithId(_ comments: String, id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    func deleteCommentById(_ id: Int) async -> Result<DefaultResponse, ServiceError> {
        .failure(.mock())
    }
    
    
}
