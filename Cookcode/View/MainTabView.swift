//
//  TabView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    let tabItemImageWidth: CGFloat = 35
    let tabItemImageHeight: CGFloat = 35
    
    init() {
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        
        Group {
            if navigateViewModel.showRecipeFormView {
                RecipeFormView()
                    .transition(.move(edge: .trailing))
            } else {
                TabView(selection: $navigateViewModel.tab) {
                    cookieView()
                    homeView()
                    refrigeratorView()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.linear(duration: 0.1), value: navigateViewModel.showRecipeFormView)
    }
    
    @ViewBuilder
    func cookieView() -> some View {
        NavigationStack {
            CookieView()
        }
        .tag(Tab.cookie)
        .tabItem {
            Tab.cookie.selectImage(navigateViewModel.tab)
                .resizable()
                .frame(width: tabItemImageWidth, height: tabItemImageHeight)
        }
    }
    
    @ViewBuilder
    func homeView() -> some View {
        NavigationStack {
            HomeView()
        }
        .tag(Tab.home)
        .tabItem {
            Tab.home.selectImage(navigateViewModel.tab)
                .resizable()
                .frame(width: tabItemImageWidth, height: tabItemImageHeight)
        }
    }
    
    @ViewBuilder
    func refrigeratorView() -> some View {
        NavigationStack {
            RefrigeratorView()
        }
        .tag(Tab.refrigerator)
        .tabItem {
            Tab.refrigerator.selectImage(navigateViewModel.tab)
                .resizable()
                .frame(width: tabItemImageWidth, height: tabItemImageHeight)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(NavigateViewModel())
    }
}
