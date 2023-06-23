//
//  ContentServiceInjector.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/20.
//

import Foundation

enum ContentServiceInjector: String, ServiceInjector {
    typealias ServiceProtocol = ContentServiceProtocol
    
    case success = "success"
    case failure = "failure"
    
    var dependency: ServiceProtocol {
        switch self {
        case .success:
            return ContentSuccessStub()
        case .failure:
            return ContentFailureStub()
        }
    }
    
    static func select(service: ServiceProtocol) -> ServiceProtocol {
        if let serviceVariable = ProcessInfo.processInfo.environment["-ContentService"] {
            return Self(rawValue: serviceVariable)?.dependency ?? service
        } else {
            return service
        }
    }
}
