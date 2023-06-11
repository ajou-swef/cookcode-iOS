//
//  AccountViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import Foundation

class AccountViewModel: ObservableObject {
    
    @Published private(set) var didSignIn: Bool = false
    @Published var deleteAccountAlertIsPresented: Bool = false
    @Published var user: UserDetail = .mock()
    @Published private var _serviceAlert: ServiceAlert = .init()
    
    private let accountService: AccountServiceProtocol
    
    var serviceAlert: ServiceAlert {
        get { _serviceAlert }
        set { _serviceAlert = newValue }
    }
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
        
        let token = UserDefaults.standard.object(forKey: ACCESS_TOKEN_KEY)
        if token != nil {
            didSignIn = true
        }
        
        Task {
            await getUser() 
        }
    }
    
    
    var didNotSignIn: Bool {
        !didSignIn
    }
    
    @MainActor
    func getUser() async {
        guard let userID = UserDefaults.standard.object(forKey: USER_ID) as? Int else {
            print("로그인 실패")
            logout()
            return
        }
        
        
        switch await accountService.getUserDetailById(userID) {
        case .success(let response):
            user = UserDetail(dto: response.data)
        case .failure(_):
            logout()
        }
        
    }
    
    
    @MainActor
    func login(_ value: Bool) async {
        didSignIn = value
        guard didSignIn else { return }
        await getUser()
        
    }
    
    func logout() {
        didSignIn = false
        UserDefaults.standard.set(nil, forKey: ACCESS_TOKEN_KEY)
        UserDefaults.standard.set(nil, forKey: REFRESH_TOKEN_KEY)
        UserDefaults.standard.set(nil, forKey: USER_ID)
    }
    
    func alertOkBottonTapped() async {
        _ = await accountService.deleteAccount()
    }
}
