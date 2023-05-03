//
//  AccountViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import Foundation

class AccountViewModel: ObservableObject {
    @Published private(set) var didSignIn: Bool = false
    
    var didNotSignIn: Bool {
        !didSignIn
    }
    
    func login(_ value: Bool) {
        didSignIn = value
    }
}
