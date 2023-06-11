//
//  ResetPasswordViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

final class ResetPasswordViewModel: ObservableObject {
    @Published var resetPasswordForm: ResetPasswordForm = .init()
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var successAlertIsPresented: Bool = false
    
    private let accountService: AccountServiceProtocol
    
    var okButtonIsAvailable: Bool {
        resetPasswordForm.everyFieldIsFilled && resetPasswordForm.passwordIsValid
    }
    
    init (accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    @MainActor
    func resetPasswordButtonTapped() async {
        let dto = PasswordFormDto(form: resetPasswordForm)
        let result = await accountService.resetPassword(dto: dto)
        
        switch result {
        case .success(_):
            successAlertIsPresented = true 
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
