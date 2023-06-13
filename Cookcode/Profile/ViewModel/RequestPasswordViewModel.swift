//
//  RequestPasswordViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

final class RequestPasswordViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var serviceAlert: ViewAlert = .init()
    @Published var dismissAlert: ViewAlert = .init()
    
    private let accountSerivce: AccountServiceProtocol
    
    init (accountSerivce: AccountServiceProtocol) {
        self.accountSerivce = accountSerivce
    }
    
    @MainActor
    func requestButtonTapped() async {
        let result = await accountSerivce.requestTemporaryPasswordByEmail(email)
        
        switch result {
        case .success(let success):
            await dismissAlert.presentAlert(title: "", message: success.message)
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
}
