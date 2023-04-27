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

    var completeButtonIsAvailable: Bool {
        !membershipForm.emailIsEmpty && membershipForm.passwordIsValid &&
        membershipForm.passwordMatch && uniqueNickname
    }
 
    var hidePasswordValidText: Bool {
        membershipForm.passwordIsEmpty || membershipForm.passwordIsValid
    }
    
    var hidePasswordMismatchText: Bool {
        !(hidePasswordValidText && !membershipForm.passwordMatch)
    }
}
