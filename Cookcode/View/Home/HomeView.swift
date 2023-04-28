//
//  HomeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("타이틀")
                
                Spacer()
                
                Text("프로필")
            }
            
            Spacer()
            
            ScrollView {
                Rectangle()
                    .frame(maxWidth: .infinity, minHeight: 900)
            }
            
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                navigateViewModel.showRecipeFormView = true
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .roundedRectangle(.ORANGE_80_FILLE)
                    .padding(.bottom, 10)
                    .padding(.trailing, 15)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
