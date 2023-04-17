//
//  MembershipViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

class MembershipViewModel: ObservableObject {
    @Published var membershipForm = MembershipForm()
    @Published private(set) var uniqueNickname: Bool = true

    var complebuttonEnables: Bool {
        !membershipForm.isEmptyEmail && membershipForm.isValidPassword &&
        membershipForm.passwordMatch && uniqueNickname
    }
 
    var hidePasswordValidText: Bool {
        membershipForm.isEmptyPassword || membershipForm.isValidPassword
    }
    
    var hidePasswordMismatchText: Bool {
        !(hidePasswordValidText && !membershipForm.passwordMatch)
    }
}
