//
//  FridgeServiceInjector.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/20.
//

import Foundation

enum FridgeServiceInjector: String, ServiceInjector {
    typealias ServiceProtocol = FridgeServiceProtocol
    
    case success = "success"
    case failure = "failure"
    
    var dependency: ServiceProtocol {
        switch self {
        case .success:
            return FridgeSuccessStub()
        case .failure:
            return FridgeFailureStub()
        }
    }
    
    static func select(service: ServiceProtocol) -> ServiceProtocol {
        if let serviceVariable = ProcessInfo.processInfo.environment["-FridgeService"] {
            return Self(rawValue: serviceVariable)?.dependency ?? service
        } else {
            return service
        }
    }
}
