//
//  CookieServiceProtocol.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import Alamofire
import Foundation

protocol CookieServiceProtocol {
    func postCookie(cookie: CookieForm) async -> Result<DefaultResponse, ServiceError>
    func getCookie() async -> Result<ServiceResponse<CookieDetailResponseDTO>, ServiceError> 
}


