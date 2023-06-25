//
//  Test.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/24.
//

import Foundation

protocol SomeProtocol {
    associatedtype NewType
}

struct SomeStruct {
    let someProperty: any SomeProtocol
    
    init(someProperty: some SomeProtocol) {
        self.someProperty = someProperty
    }
    
    func someMethod(_ someProperty: some SomeProtocol) {
        
    }
}
