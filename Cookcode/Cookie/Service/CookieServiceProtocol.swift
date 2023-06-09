//
//  CookieServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Alamofire
import Foundation

protocol CookieServiceProtocol: CommentServiceProtocol {
    func deleteCookie(_ id: Int) async -> Result<DefaultResponse, ServiceError> 
    func likesCookie(_ cookie: CookieDetail) async -> Result<DefaultResponse, ServiceError>
    func postCookie(cookie: CookieForm, closure: @escaping (Progress) -> (Void)) async -> Result<DefaultResponse, ServiceError>
    func getCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError>
    func getCookieCellByUserId(_ id: Int, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError>
    func getCookieCellsByQuery(_ query: String) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> 
}


