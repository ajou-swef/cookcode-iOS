//
//  ModifyCookieViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/09.
//

import SwiftUI

final class ModifyCookieViewModel: PatchViewModel {
    @Published var serviceAlert: ViewAlert = .init()
    
    @Published var useTrashButton: Bool = true
    @Published var deleteAlertIsPresented: Bool = false
    @Published var cookieForm: CookieForm  = .init()
    
    let cookieId: Int
    private let cookieService: CookieServiceProtocol
    
    init(cookieService: CookieServiceProtocol, cookieDetail: CookieDetail) {
        self.cookieService = cookieService
        cookieForm = CookieForm(detail: cookieDetail)
        cookieId = cookieDetail.contentId
    }
    
    @MainActor
    func mainButtonTapped(dismissAction: DismissAction) async {
        let result = await cookieService.patchCookie(id: cookieId, cookieForm: cookieForm)
        
        switch result {
        case .success(_):
            dismissAction()
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    @MainActor
    func deleteOkButtonTapped(dismissAction: DismissAction) async {
        let result = await cookieService.deleteCookie(cookieId)
        
        switch result {
        case .success(_):
            dismissAction()
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    
}
