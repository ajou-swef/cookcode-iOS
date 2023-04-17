//
//  MembershipForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import Foundation

struct MembershipForm {
    var email: String = ""
    var nickname: String = ""
    var password: String = ""
    var passwordCheck: String = ""
    
    var passwordMatch: Bool {
        password == passwordCheck
    }
    
    var isNicknaemEmpty: Bool {
        nickname.isEmpty
    }
}
