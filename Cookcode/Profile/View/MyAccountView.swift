//
//  MyAccountView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct MyAccountView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    @StateObject private var userFormViewModel: UserFormViewModel = UserFormViewModel(accountService: AccountService())
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                userProfile()
                
                List {
                    Button {
                        dismiss()
                        let myId = UserDefaults.standard.integer(forKey: USER_ID)
                        let homeIdPath = HomeIdPath(path: .profile, id: myId)
                        navigateViewModel.navigateWithHome(homeIdPath)
                    } label: {
                        Text("내 채널")
                            .foregroundColor(.primary)
                            .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                    }
                    
                    Button {
                        navigateViewModel.clear()
                        accountViewModel.logout()
                    } label: {
                        Text("로그아웃")
                            .foregroundColor(.primary)
                            .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                    }


                }
            }
            .background(Color.gray_bcbcbc.opacity(0.5))
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
    
    @ViewBuilder
    private func userProfile() -> some View {
        Group {
            Group {
                if let imageURL = userFormViewModel.user.thumbnail {
                    if let url = URL(string: imageURL) {
                        KFImage(url)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                    }
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 18)
                        )
                }
            }
            .overlay(alignment: .bottomTrailing) {
                modifyImageButton()
            }
            
            HStack {
                Text(userFormViewModel.user.nickname)
                    .font(.custom(CustomFont.interBold.rawValue, size: 20))
                    .padding(.bottom, -5)
                    .offset(y: -10)
            }
        }
    }

    @ViewBuilder
    private func modifyImageButton() -> some View {
        PhotosPicker(selection: $userFormViewModel.profileForm.photosPickerItem) {
            Circle()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .overlay {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 15, height: 15)
                }
                .onChange(of: userFormViewModel.profileForm.photosPickerItem) { newValue in
                    Task { await userFormViewModel.postProfileImage() }
                }
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
            .environmentObject(AccountViewModel(accountService: AccountSuccessService()))
    }
}
