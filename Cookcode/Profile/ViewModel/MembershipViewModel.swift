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
    @Published var serviceAlert: ServiceAlert = .init()
    
    @Published var remainTime: Double = 300
    @Published var timer = Timer()
    @Published var startTime = Date.now
    
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
            serviceAlert.presentAlert(serviceError)
        }
    }
    
    func setNicknameCheckComplteToFalse() {
        membershipForm.setNicknameCheckComplte(false)
    }
    
    @MainActor
    func signUp(dismiss: DismissAction) async {
        let result = await accountService.signUp(membershipForm: membershipForm)
        
        switch result {
        case .success(_):
            dismiss()
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    func getCode() {
        
    }
    
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
