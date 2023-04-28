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
    
    let recipeCellHeight: CGFloat = 200
    let offsetY: CGFloat = 20
    
    var body: some View {
        VStack {
            HStack {
                Text("타이틀")
                
                Spacer()
                
                Button {
                    navigateViewModel.navigateToOuter(.profile)
                } label: {
                    Text("프로필")
                }

            }
            
            Spacer()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20 + offsetY) {
                    ForEach(0..<10, id: \.self) { _ in
                        RecipeCellView(offsetY: offsetY)
                            .frame(height: recipeCellHeight)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, offsetY)
            }
            
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                navigateViewModel.navigateToOuter(.recipe)
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
