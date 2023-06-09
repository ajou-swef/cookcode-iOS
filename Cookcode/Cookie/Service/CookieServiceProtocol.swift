//
//  CookieServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Alamofire
import Foundation

protocol CookieServiceProtocol: CommentServiceProtocol {
    func likesCookie(_ cookie: CookieDetail) async -> Result<DefaultResponse, ServiceError>
    func postCookie(cookie: CookieForm, closure: @escaping (Progress) -> (Void)) async -> Result<DefaultResponse, ServiceError>
    func fetchCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError>
    func fetchCookieCellByUserId(_ id: Int, page: Int) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError>
    func searchCookieCellsBy(_ query: String) async -> Result<ServiceResponse<PageResponse<CookieDetailDTO>>, ServiceError> 
}


