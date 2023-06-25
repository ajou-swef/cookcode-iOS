//
//  RequestPasswordView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct RequestPasswordView: View {
    
    @StateObject private var viewModel: RequestPasswordViewModel
    @Environment(\.dismiss) var dismiss
    
    init(accountService: AccountServiceProtocol = AccountService()) {
        self._viewModel = StateObject(wrappedValue: RequestPasswordViewModel(accountSerivce: accountService))
    }
    
    var body: some View {
        VStack {
            TextField("이메일을 입력하세요.", text: $viewModel.email)
                .padding(.leading)
                .padding(.vertical, 8)
                .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                }
            
            Button {
                Task { await viewModel.requestButtonTapped() }
            } label: {
                Text("임시 비밀번호 발급")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
                    .padding(.vertical, 8)
                    .background {
                        Color.mainColor
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                    }
                    .padding(.top, 10)
            }
            .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
                ViewAlert.cancelButton
            }

        }
        .padding(.horizontal)
        .alert("", isPresented: $viewModel.dismissAlert.isPresented, actions: {
            Button {
                dismiss()
            } label: {
                Text("확인")
            }
        }, message: {
            Text("\(viewModel.dismissAlert.title)")
        })
    }
}

struct RequestPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RequestPasswordView()
    }
}
