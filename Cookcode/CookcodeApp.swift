//
//  CookcodeApp.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

@main
struct CookcodeApp: App {
    
    @StateObject private var navigateViewModel: NavigateViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigateViewModel)
        }
    }
}
