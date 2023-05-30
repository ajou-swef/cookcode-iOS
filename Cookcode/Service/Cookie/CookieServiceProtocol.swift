//
//  CookieServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Alamofire
import Foundation

protocol CookieServiceProtocol: CommentServiceProtocol {
    func postCookie(cookie: CookieForm) async -> Result<DefaultResponse, ServiceError>
    func fetchCookie() async -> Result<ServiceResponse<[CookieDetailDTO]>, ServiceError> 
}


