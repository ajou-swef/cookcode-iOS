//
//  TabView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import Introspect

struct MainTabView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    let tabItemImageWidth: CGFloat = 35
    let tabItemImageHeight: CGFloat = 35
    
    var body: some View {
        
        Group {
            if let path = navigateViewModel.outerPath {
                switch path {
                case .recipe:
                    RecipeFormView()
                        .transition(.move(edge: .trailing))
                case .profile:
                    EmptyView()
                        .transition(.move(edge: .trailing))
                }
            } else {
                TabView(selection: $navigateViewModel.tab) {
                    cookieView()
                    homeView()
                    refrigeratorView()
                }
                .transition(.move(edge: .leading))
                .introspectTabBarController {
                    let appearance: UITabBarAppearance = UITabBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    $0.tabBar.scrollEdgeAppearance = appearance
                    $0.tabBar.standardAppearance = appearance
                }
            }
        }
        .animation(.linear(duration: 0.1), value: navigateViewModel.outerPath)
    }
    
    @ViewBuilder
    func cookieView() -> some View {
        NavigationStack {
            CookieView()
        }
        .tint(.mainColor)
        .tag(Tab.cookie)
        .tabItem {
            Tab.cookie.selectImage(navigateViewModel.tab)
                .resizable()
                .frame(width: tabItemImageWidth, height: tabItemImageHeight)
        }
    }
    
    @ViewBuilder
    func homeView() -> some View {
        NavigationStack(path: $navigateViewModel.homePath) {
            HomeView()
                .navigationDestination(for: RecipeCell.self) { recipe in
                    RecipePreviewView(recipeCell: recipe)
                }
                .navigationDestination(for: HomePath.self) { path in
                    switch path {
                    case .search:
                        SearchRecipeView()
                    }
                }
        }
        .tint(.mainColor)
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
        .tint(.mainColor)
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
