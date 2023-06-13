//
//  MembershipViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

class MembershipViewModel: ObservableObject {
    
    private let timeDuration: Double = 300
    let accountService: AccountServiceProtocol
    @Published var membershipForm = MembershipForm()
    @Published var inputCode: String = "" 
    @Published var serviceAlert: ViewAlert = .init()
    
    @Published var remainTime: Double = 300
    @Published var timer = Timer()
    @Published var startTime = Date.now
    
    @Published var missmatchAlertIsPresented: Bool = false
    @Published var successAlertIsPresented: Bool = false
    @Published var signInSuccess: Bool = false
    
    private var assignedCode: String = ""
    
    var timeText: String {
        let minutes = Int(remainTime) / 60 % 60
        let seconds = Int(remainTime) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    var nicknameIsEmpty: Bool {
        membershipForm.nicknameIsEmpty
    }
    
    var nicknameCheckComplete: Bool {
        membershipForm.nicknameCheckComplete
    }
    
    var nicknameIsUnique: Bool {
        membershipForm.nicknameIsUnique
    }
    
    var completeButtonIsAvailable: Bool {
        !membershipForm.emailIsEmpty && membershipForm.passwordIsValid &&
        membershipForm.passwordMatch && membershipForm.nicknameIsUnique
        && membershipForm.nicknameCheckComplete
    }
 
    var hidePasswordValidText: Bool {
        membershipForm.passwordIsEmpty || membershipForm.passwordIsValid
    }
    
    var hidePasswordMismatchText: Bool {
        !(hidePasswordValidText && !membershipForm.passwordMatch)
    }
    
    init (accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    @MainActor
    func checkNickname() async {
        let result = await accountService.check(membershipForm.nickname)
        
        switch result {
        case .success(let data):
            membershipForm.nicknameIsUnique = data.data.isUnique
        case .failure(let serviceError):
            serviceAlert.presentServiceError(serviceError)
        }
    }
    
    
    func setNicknameCheckComplteToFalse() {
        membershipForm.setNicknameCheckComplte(false)
    }
    
    @MainActor
    func checkCode() async {
        guard inputCode.count == 6 else { return }
        guard remainTime > 0 else { return missmatchAlertIsPresented = false }
        
        if assignedCode == inputCode {
            await signUp()
        } else {
            missmatchAlertIsPresented = true 
        }
    }
    
    @MainActor
    func signUp() async {
        let result = await accountService.signUp(membershipForm: membershipForm)
        
        switch result {
        case .success(_):
            signInSuccess = true 
            successAlertIsPresented = true 
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    @MainActor
    func getCode() async {
        let result = await accountService.requestEmailCode(email: membershipForm.email)
        
        switch result {
        case .success(let success):
            assignedCode = String(success.data) 
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    @MainActor
    func startTimer() {
        timer.invalidate()
        startTime = Date.now
        remainTime = timeDuration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
            if self.remainTime > 0 {
                self.remainTime -= 1
            } else {
                self.timer.invalidate()
            }
        })
    }
    
    @MainActor
    func setTimeRemaining() {
          let curTime = Date.now
          let diffTime = curTime.distance(to: startTime)
          let result = Double(diffTime.formatted())!
          remainTime = 5*60 + result
          
          if remainTime < 0 {
              remainTime = 0
          }
      }
}
