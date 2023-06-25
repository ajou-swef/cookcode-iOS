//
//  ContentView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    var body: some View {
        Group {
            LoginView()
                .hidden(accountViewModel.didSignIn)

            MainTabView()
                .hidden(accountViewModel.didNotSignIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
