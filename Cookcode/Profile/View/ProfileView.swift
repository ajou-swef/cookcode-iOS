//
//  ProfileView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/01.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var accountViewModel: AccountViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    var body: some View {
        NavigationStack(path: $navigateViewModel.profilePath) {
            List {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.all, 6)
                        .background(Circle().stroke(lineWidth: 2))
                    
                    VStack(alignment: .leading) {
                        Text(accountViewModel.user?.nickname ?? "")
                            .font(CustomFontFactory.INTER_SEMIBOLD_20)
                        
                        Text(accountViewModel.user?.email ?? "")
                            .font(CustomFontFactory.INTER_SEMIBOLD_14)
                    }
                }
                
                Button {
                    navigateViewModel.navigateWithProfile(ProfilePath.myRecipe)
                } label: {
                    Text("내 레시피")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }
                
                Button {
                    accountViewModel.logout()
                    navigateViewModel.clear()
                } label: {
                    Text("로그아웃")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }
                
                Button {
                    accountViewModel.deleteAccountAlertIsPresented = true
                } label: {
                    Text("계정 삭제")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.red)
                }
                .alert("계정을 삭제하시겠습니까?", isPresented: $accountViewModel.deleteAccountAlertIsPresented) {
                    Button("취소", role: .cancel) { }
                    Button("확인") {
                        Task {
                            await accountViewModel.alertOkBottonTapped() 
                            accountViewModel.logout()
                            navigateViewModel.clear()
                        }
                    }
                }
            }
            .alert(accountViewModel.serviceAlert.title, isPresented: $accountViewModel.serviceAlert.isPresented) {
                ServiceAlert.CANCEL_BUTTON
            }
            .tint(.mainColor)
            .navigationDestination(for: ProfilePath.self) { path in
                switch path {
                case .myRecipe:
                    MyRecipeView()
                }
            }
            .navigationTitle("프로필")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        navigateViewModel.dismissOuter()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }

                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
