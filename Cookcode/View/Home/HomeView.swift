//
//  HomeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    var body: some View {
        ScrollView {
     
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                navigateViewModel.isPresentedSlide = true 
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
