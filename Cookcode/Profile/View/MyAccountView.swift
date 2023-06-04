//
//  MyAccountView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

struct MyAccountView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                
                Button {
                    dismiss()
                    let myId = UserDefaults.standard.integer(forKey: USER_ID)
                    let homeIdPath = HomeIdPath(path: .profile, id: myId)
                    navigateViewModel.navigateWithHome(homeIdPath)
                } label: {
                    Text("내 채널")
                        .foregroundColor(.primary)
                }
                
                Button {
                    navigateViewModel.clear()
                    accountViewModel.logout()
                } label: {
                    Text("로그아웃")
                        .foregroundColor(.primary)
                }


            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
