//
//  MembershipView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

struct MembershipView: View {
    
    enum Field: Hashable {
        case email
        case nickname
        case password
        case passwordCheck
    }
    
    @StateObject private var viewModel = MembershipViewModel()
    @FocusState private var focus: Field?
    
    var body: some View {
        VStack(spacing: 20) {
            
            TextField("이메일", text: $viewModel.membershipForm.email)
                .focused($focus, equals: .email)
                .padding(.leading, 10)
                .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                  focused: focus == .email)

                
            
            TextField("닉네임", text: $viewModel.membershipForm.nickname)
                .padding(.leading, 10)
                .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                  focused: focus == .nickname)
                .focused($focus, equals: .nickname)
            
            TextField("비밀번호", text: $viewModel.membershipForm.password)
                .padding(.leading, 10)
                .focused($focus, equals: .password)
                .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                  focused: focus == .password)
            
            
            TextField("비밀번호 확인", text: $viewModel.membershipForm.passwordCheck)
                .padding(.leading, 10)
                .focused($focus, equals: .passwordCheck)
                .roundedRectangle(.GRAY_320_STROKE, alignment: .leading,
                                  focused: focus == .passwordCheck)
        }
        .navigationTitle(
            Text("회원가입")
        )
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            focus = .email
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            focus = nil 
        }
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
}
