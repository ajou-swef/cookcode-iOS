//
//  RequestPasswordViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

final class RequestPasswordViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var dismissAlert: ServiceAlert = .init()
    
    private let accountSerivce: AccountServiceProtocol
    
    init (accountSerivce: AccountServiceProtocol) {
        self.accountSerivce = accountSerivce
    }
    
    @MainActor
    func requestButtonTapped() async {
        let result = await accountSerivce.requestTemporaryPasswordByEmail(email)
        
        switch result {
        case .success(let success):
            dismissAlert.presentAlert(title: success.message)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
