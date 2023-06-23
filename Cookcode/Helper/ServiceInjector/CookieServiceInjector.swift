//
//  CookieServiceInjector.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/20.
//

import Foundation

enum CookieServiceInjector: String, ServiceInjector {
    typealias ServiceProtocol = CookieServiceProtocol
    
    case success = "success"
    case failure = "failure"
    
    var dependency: ServiceProtocol {
        switch self {
        case .success:
            return CookieSuccessStub()
        case .failure:
            return CookieFailureStub()
        }
    }
    
    static func select(service: ServiceProtocol) -> ServiceProtocol {
        if let serviceVariable = ProcessInfo.processInfo.environment["-CookieService"] {
            return Self(rawValue: serviceVariable)?.dependency ?? service
        } else {
            return service
        }
    }
}

