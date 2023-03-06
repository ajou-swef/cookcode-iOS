//
//  LoginView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("로그인 화면")
                
                NavigationLink {
                    MembershipView()
                } label: {
                    Text("회원가입")
                        .accessibilityIdentifier("MembershipViewNavigationLink")
                }

            }
            .accessibilityIdentifier("LoginView")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
