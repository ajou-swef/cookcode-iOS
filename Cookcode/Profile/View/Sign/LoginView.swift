//
//  LoginView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

struct LoginView: View {
    
    enum Field: Hashable {
        case email
        case password
    }
    
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State private var path: NavigationPath = NavigationPath()
    @StateObject private var viewModel = LoginViewModel(accountService: AccountService())
    @FocusState private var focused: Field?
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 10) {
                    Spacer()
                    
                    Image("cookcode.logo")
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Text("cookcode")
                        .font(.custom(CustomFont.interBold.rawValue, size: 30))
                        .padding(.bottom, 30)
                    
                    emailField()
                    passwordField()
                    loginButton()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        navigateCredentialButton()
                        navigateMembershipViewButton()
                    }
                    .frame(maxWidth: 320, alignment: .trailing)
                    
                    Spacer()
                   
                }
                .padding()
            }
            .onDisappear {
                viewModel.clear()
            }
            .frame(maxWidth: .infinity)
            .accessibilityIdentifier("LoginView")
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ServiceAlert.cancelButton
        }
    }
    
    @ViewBuilder
    private func emailField() -> some View {
        TextField("이메일", text: $viewModel.signInForm.email)
            .font(CustomFontFactory.INTER_BOLD_16)
            .padding(10)
            .focused($focused, equals: .email)
            .frame(maxWidth: 320, maxHeight: 50, alignment: .leading)
            .foregroundColor(focused == .email ? .mainColor : .gray808080)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .fill(focused == .email ? Color.mainColor :  Color.gray808080)
            }
    }
    
    @ViewBuilder
    private func loginButton() -> some View {
        Button {
            Task {
                let loginDidSuccess = await viewModel.signIn()
                await accountViewModel.login(loginDidSuccess)
            }
        } label: {
            Text("로그인")
                .foregroundColor(.white)
                .font(CustomFontFactory.INTER_BOLD_16)
                .roundedRectangle(.ORANGE_320_FILLED, focused: true)
        }
    }
    
    @ViewBuilder
    private func passwordField() -> some View {
        SecureField("비밀번호", text: $viewModel.signInForm.password)
            .font(CustomFontFactory.INTER_BOLD_16)
            .padding(10)
            .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                              focused: focused == .password)
            .focused($focused, equals: .password)
            .onChange(of: focused) { newValue in
                focused = newValue
            }
    }
    
    @ViewBuilder
    private func navigateCredentialButton() -> some View {
        NavigationLink {
            RequestPasswordView()
        } label: {
            Text("비밀번호 찾기")
                .foregroundColor(.mainColor)
                .font(.custom(CustomFont.interRegular.rawValue, size: 15))
        }
    }

    @ViewBuilder
    private func navigateMembershipViewButton() -> some View {
        NavigationLink {
            MembershipView(accountService: AccountSuccessService())
        } label: {
            Text("회원가입")
                .foregroundColor(.mainColor)
                .font(.custom(CustomFont.interRegular.rawValue, size: 15))
                .accessibilityIdentifier("MembershipViewNavigationLink")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
