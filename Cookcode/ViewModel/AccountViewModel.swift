//
//  AccountViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import Foundation

class AccountViewModel: ObservableObject {
    @Published private(set) var didSignIn: Bool = false
    
    init() {
        let token = UserDefaults.standard.object(forKey: ACCESS_TOKEN_KEY)
        if token != nil {
            didSignIn = true
        }
    }
    
    
    var didNotSignIn: Bool {
        !didSignIn
    }
    
    func login(_ value: Bool) {
        didSignIn = value
    }
}
