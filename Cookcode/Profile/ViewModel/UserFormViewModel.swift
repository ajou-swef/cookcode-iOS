//
//  UserFormViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import SwiftUI

final class UserFormViewModel: ObservableObject {
    
    @Published var deleteAccountAlertIsPresented: Bool = false
    
    @Published var user: UserDetail = .mock()
    @Published var profileForm: ProfileForm = .mock()
    @Published var serviceAlert: ServiceAlert = .init()
    
    private let accountService: AccountServiceProtocol
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
        
        Task { await getUser() }
    }

    @MainActor
    func getUser() async {
        let userID = UserDefaults.standard.integer(forKey: USER_ID)
        
        switch await accountService.getUserDetailById(userID) {
        case .success(let response):
            user = UserDetail(dto: response.data)
            profileForm = ProfileForm(detail: user)
        case .failure(_):
            break
        }
        
    }
    
    @MainActor
    func postProfileImage() async {
        guard let imageData = try? await profileForm.photosPickerItem?.loadTransferable(type: Data.self) else { return }
        profileForm.data = imageData
        let result = await accountService.updateProfile(profileForm)
        
        switch result {
        case .success(_):
            await getUser()
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }

    
    func alertOkBottonTapped() async {
        _ = await accountService.deleteAccount()
    }
}
