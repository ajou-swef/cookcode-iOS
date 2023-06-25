//
//  AuthenticateEmailViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct AuthenticateEmailView: View {
    
    @ObservedObject var viewModel: MembershipViewModel
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    
    var body: some View {
        VStack {
            guide()
            certificationTextField()
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented, actions: {
            ViewAlert.cancelButton
        })
        .navigationTitle("이메일 인증")
        .onChange(of: viewModel.inputCode, perform: { newValue in
            Task { await viewModel.checkCode() }
        })
        .onChange(of: scenePhase, perform: { scenePhsae in
               switch scenePhsae {
               case .active:
                   viewModel.setTimeRemaining()
               case .inactive:
                   break
               case .background:
                   break
               @unknown default:
                   break
               }
           })
           .onAppear {
               Task {
                   await viewModel.getCode()
                   viewModel.startTimer()
               }
           }
    }
    
    @ViewBuilder
    private func guide() -> some View {
        Group {
            Text("이메일로\n인증번호가 발송되었습니다.")
                .multilineTextAlignment(.center)
                .font(.custom(CustomFont.interSemiBold.rawValue, size: 20))
            
            Text("6자리 숫자를 입력해주세요.")
                .padding(.top, 50)
                .font(.custom(CustomFont.interRegular.rawValue, size: 15))
                .alert("성공", isPresented: $viewModel.successAlertIsPresented) {
                    Button {
                        dismiss() 
                    } label: {
                        Text("확인")
                    }
                } message: {
                    Text("회원가입에 성공했습니다.")
                }
        }
        .alert("실패", isPresented: $viewModel.missmatchAlertIsPresented) {
            Button("확인", role: .cancel) { }
        } message: {
            Text("인증번호가 일치하지 않습니다.")
        }

    }
    
    @ViewBuilder
    private func certificationTextField() -> some View {
        HStack {
            TextField("인증번호를 입력해주세요", text: $viewModel.inputCode)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(viewModel.timeText)")
        }
        .padding(.horizontal)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
        }
        .padding(.horizontal, 50)
    }
    
}

struct AuthenticateEmailViewModel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticateEmailView(viewModel: MembershipViewModel(accountService: AccountServiceSuccessStub()))
        }
    }
}
