//
//  AccountSerivceInjector.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/20.
//

import Foundation

enum AccountServiceInjector: String, ServiceInjector {
    
    
    typealias ServiceInjector = AccountServiceProtocol
    
    case success = "success"
    case failure = "failure"
   
    var dependency: AccountServiceProtocol {
       switch self {
       case .success:
           return AccountServiceSuccessStub()
       case .failure:
           return AccountServiceFailureStub()
       }
    }
    
    static func select(service: AccountServiceProtocol) -> AccountServiceProtocol {
       if let serviceVariable = ProcessInfo.processInfo.environment["-AccountService"] {
           return Self(rawValue: serviceVariable)?.dependency ?? service
       } else {
           return service
       }
    }
}
