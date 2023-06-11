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
                    navigateToMyChannelButton()
                    navigateToMyPublishersButton()
                    navigateToMySubscribersButton()
                    
                    Button {
                        userFormViewModel.requestAuthorityAlertIsPresented = true 
                    } label: {
                        Text("인플루언서 권한 요청")
                            .foregroundColor(.primary)
                            .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                    }
                    .alert("권한 요청", isPresented: $userFormViewModel.requestAuthorityAlertIsPresented) {
                        Button("취소", role: .cancel) { }
                        Button {
                            Task { await userFormViewModel.requesetOkButtonTapped() }
                        } label: {
                            Text("확인")
                        }

                    } message: {
                        Text("인플루언서 권한을 요청하시겠습니까?")
                    }
                    
                    Group {
                        NavigationLink {
                            ManageAuthView()
                        } label: {
                            Text("멤버쉽 생성")
                                .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                        }
                        .presentIf(accountViewModel.user.authority == .influencer)
                        
                        NavigationLink {
                            JoineMembershipList()
                        } label: {
                            Text("가입한 멤버쉽")
                                .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                        }
                        
                        NavigationLink {
                            TreatAuthRequestView()
                        } label: {
                            Text("권한 관리")
                                .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                        }
                        .presentIf(accountViewModel.user.authority == .admin)

                        
                        NavigationLink {
                            ResetPasswordView()
                        } label: {
                            Text("비밀번호 변경")
                                .foregroundColor(.primary)
                                .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                        }
                    }

                    
                    Button {
                        navigateViewModel.clear()
                        accountViewModel.logout()
                    } label: {
                        Text("로그아웃")
                            .foregroundColor(.primary)
                            .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                    }
                    
                    Button {
                        userFormViewModel.deleteAccountAlertIsPresented = true 
                    } label: {
                        Text("계정삭제")
                            .foregroundColor(.red)
                            .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
                    }

                }
            }
            .alert("계정을 삭제하시겠습니까?", isPresented: $userFormViewModel.deleteAccountAlertIsPresented, actions: {
                Button("취소", role: .cancel) { }
                Button {
                    Task {
                        await userFormViewModel.alertOkBottonTapped()
                        navigateViewModel.clear()
                        accountViewModel.logout()
                    }
                } label: {
                    Text("삭제")
                        .foregroundColor(.red)
                }

            })
            .navigationTitle("내 계정")
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
    private func navigateToMySubscribersButton() -> some View {
        Button {
            dismiss()
            let homeIdPath = HomeIdPath(path: .subscriber, id: nil)
            navigateViewModel.navigateWithHome(homeIdPath)
        } label: {
            Text("내 구독자들")
                .foregroundColor(.primary)
                .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
        }
    }
    
    @ViewBuilder
    private func navigateToMyPublishersButton() -> some View {
        Button {
            dismiss()
            let homeIdPath = HomeIdPath(path: .publisher, id: nil)
            navigateViewModel.navigateWithHome(homeIdPath)
        } label: {
            Text("구독 목록")
                .foregroundColor(.primary)
                .font(.custom(CustomFont.interSemiBold.rawValue, size: 15))
        }
    }
    
    @ViewBuilder
    private func navigateToMyChannelButton() -> some View {
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
                                Circle()
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
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.gray_bcbcbc)
                .frame(width: 40, height: 30)
                .overlay {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 20, height: 15)
                }
                .onChange(of: userFormViewModel.profileForm.photosPickerItem) { newValue in
                    Task { await userFormViewModel.postProfileImage() }
                }
                .offset(x: 10)
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
            .environmentObject(AccountViewModel(accountService: AccountSuccessService()))
    }
}
