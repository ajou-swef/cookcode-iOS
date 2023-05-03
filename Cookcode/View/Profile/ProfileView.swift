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
                
                Button {
                    navigateViewModel.navigateWithProfile(ProfilePath.myRecipe)
                } label: {
                    Text("내 레시피")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }
                
                Button {
                    accountViewModel.logout()
                } label: {
                    Text("로그아웃")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }
                
                Button {
                    
                } label: {
                    Text("계정 삭제")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.red)
                }
            }
            .tint(.mainColor)
            .navigationDestination(for: RecipeCellDto.self) { recipeCell in
                RecipeView(recipeCell: recipeCell)
            }
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
