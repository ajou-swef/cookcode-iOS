//
//  PasswordFormDto.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

struct PasswordFormDto: Encodable {
    let password: String
    let newPassword: String
}

extension PasswordFormDto {
    init (form: ResetPasswordForm) {
        password = form.currentPassword
        newPassword = form.newPassword
    }
}
