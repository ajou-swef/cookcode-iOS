//
//  ServiceInjector.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/20.
//

import Foundation

protocol ServiceInjector {
    associatedtype ServiceProtocol
    
    var dependency: ServiceProtocol { get }
    
    static func select(service: ServiceProtocol) -> ServiceProtocol
}
