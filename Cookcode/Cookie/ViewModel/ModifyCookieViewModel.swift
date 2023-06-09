//
//  ModifyCookieViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/09.
//

import SwiftUI

final class ModifyCookieViewModel: PatchViewModel {
    @Published var serviceAlert: ServiceAlert = .init()
    
    @Published var useTrashButton: Bool = true
    @Published var deleteAlertIsPresented: Bool = false
    @Published var cookieForm: CookieForm  = .init()
    
    private let cookieId: Int
    private let cookieService: CookieServiceProtocol
    
    init(cookieService: CookieServiceProtocol, cookieDetail: CookieDetail) {
        self.cookieService = cookieService
        cookieForm = CookieForm(detail: cookieDetail)
        cookieId = cookieDetail.contentId
    }
    
    
    func mainButtonTapped(dismissAction: DismissAction) async {
        
    }
    
    @MainActor
    func deleteOkButtonTapped(dismissAction: DismissAction) async {
        let result = await cookieService.deleteCookie(cookieId)
        
        switch result {
        case .success(_):
            dismissAction()
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    
}
