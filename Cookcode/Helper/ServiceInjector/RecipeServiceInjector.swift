//
//  RecipeServiceInjector.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/20.
//

import Foundation
import cookcode_service

enum RecipeServiceInjector: String, ServiceInjector {
    typealias ServiceProtocol = RecipeServiceProtocol
    
    case success = "success"
    case failure = "failure"
    
    var dependency: ServiceProtocol {
        switch self {
        case .success:
            return RecipeServiceSuccessStub()
        case .failure:
            return RecipeFailureServiceStub()
        }
    }
    
    static func select(service: ServiceProtocol) -> ServiceProtocol {
        if let serviceVariable = ProcessInfo.processInfo.environment["-RecipeService"] {
            return Self(rawValue: serviceVariable)?.dependency ?? service
        } else {
            return service
        }
    }
}
