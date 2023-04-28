//
//  HomeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import Introspect

struct HomeView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel = HomeViewModel()
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("타이틀")
                
                Spacer()
                
                Text("프로필")
            }
            
            Spacer()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    Rectangle()
                        .foregroundColor(.mainColor)
                        .frame(height: 140)
                    
                    Rectangle()
                        .foregroundColor(.mainColor)
                        .frame(height: 140)
                    
                    Rectangle()
                        .foregroundColor(.mainColor)
                        .frame(height: 140)
                    
                    Rectangle()
                        .foregroundColor(.mainColor)
                        .frame(height: 140)
                    
                    Rectangle()
                        .foregroundColor(.mainColor)
                        .frame(height: 140)
                    
                    Rectangle()
                        .foregroundColor(.mainColor)
                        .frame(height: 140)
                }
                .padding(.horizontal, 10)
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
