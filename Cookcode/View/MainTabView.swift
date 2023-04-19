//
//  TabView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    var body: some View {
        
        Group {
            if navigateViewModel.isPresentedSlide {
                SlidInfoView()
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
        .animation(.linear(duration: 0.1), value: navigateViewModel.isPresentedSlide)
    }
    
    @ViewBuilder
    func cookieView() -> some View {
        NavigationStack {
            CookieView()
        }
        .tag(Tab.cookie)
        .tabItem {
            Tab.cookie.selectImage(navigateViewModel.tab)
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
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(NavigateViewModel())
    }
}
