//
//  CookcodeApp.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

@main
struct CookcodeApp: App {
    
    @StateObject private var updateCellViewModel: UpdateCellViewModel = .init()
    @StateObject private var navigateViewModel: NavigateViewModel = .init()
    @StateObject private var accountViewModel: AccountViewModel = .init(accountService: AccountService())
    @StateObject private var progressViewModel: CookieProgress = .init(cookieService: CookieService())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigateViewModel)
                .environmentObject(accountViewModel)
                .environmentObject(updateCellViewModel)
                .environmentObject(progressViewModel)
                .onOpenURL {
                    navigateViewModel.separateURL($0.absoluteString)
                }
        }
    }
    
    func showFonts() {
        for family: String in UIFont.familyNames {
            print(family)
            for names : String in UIFont.fontNames(forFamilyName: family){
                print("=== \(names)")
            }
        }
    }
}
