//
//  CookieServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Alamofire
import Foundation
import cookcode_service

protocol CookieServiceProtocol: CommentServiceProtocol {
    func patchCookie(id: Int, cookieForm: CookieForm) async -> Result<DefaultResponse, ServiceError> 
    func deleteCookie(_ id: Int) async -> Result<DefaultResponse, ServiceError> 
    func likesCookie(_ cookie: CookieDetail) async -> Result<DefaultResponse, ServiceError>
    func postCookie(cookie: CookieForm, closure: @escaping (Progress) -> (Void)) async -> Result<DefaultResponse, ServiceError>
    func getCookieByCookieId(_ id: Int) async -> Result<ServiceResponse<CookieDetailDTO>, ServiceError> 
    func getCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError>
    func getCookieCellByUserId(_ id: Int, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError>
    func getCookieCellsByQuery(_ query: String, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> 
}


