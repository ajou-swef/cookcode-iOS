//
//  ResetPasswordView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @StateObject private var viewModel: ResetPasswordViewModel
    @FocusState private var focused: Field?
    
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    enum Field: Hashable {
        case currentPassword
        case newPassword
        case passwordCheck
    }
    
    init(accountService: AccountServiceProtocol = AccountService()) {
        self._viewModel = StateObject(wrappedValue: ResetPasswordViewModel(accountService: AccountService()))
    }
    
    var body: some View {
        VStack {
            SecureField("현재 비밀번호", text: $viewModel.resetPasswordForm.currentPassword)
                .font(CustomFontFactory.INTER_BOLD_16)
                .padding(10)
                .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                  focused: focused == .currentPassword)
                .focused($focused, equals: .currentPassword)
            
            SecureField("새 비밀번호", text: $viewModel.resetPasswordForm.newPassword)
                .font(CustomFontFactory.INTER_BOLD_16)
                .padding(10)
                .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                  focused: focused == .newPassword)
                .focused($focused, equals: .newPassword)
            
            
            SecureField("비밀번호 확인", text: $viewModel.resetPasswordForm.passwordCheck)
                .font(CustomFontFactory.INTER_BOLD_16)
                .padding(10)
                .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                  focused: focused == .passwordCheck)
                .focused($focused, equals: .passwordCheck)
            
            resetButton()
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ViewAlert.cancelButton
        }
    }
    
    @ViewBuilder
    private func resetButton() -> some View {
        Button {
            Task { await viewModel.resetPasswordButtonTapped() }
        } label: {
            Text("비밀번호 초기화")
                .foregroundColor(.white)
                .font(CustomFontFactory.INTER_BOLD_16)
                .roundedRectangle(.ORANGE_320_FILLED, focused: true)
        }
        .alert("성공", isPresented: $viewModel.successAlertIsPresented) {
            Button {
                navigateViewModel.clear()
                accountViewModel.logout()
            } label: {
                Text("확인")
            }

        } message: {
            Text("비밀번호를 변경했습니다.")
        }

        
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(AccountViewModel(accountService: AccountSuccessService()))
            .environmentObject(NavigateViewModel())
    }
}
