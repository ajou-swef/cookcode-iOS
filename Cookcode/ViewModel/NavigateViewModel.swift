//
//  NavigateViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

class NavigateViewModel: ObservableObject {
    
    @Published var tab: Tab = .home
    
    @Published var recipePath: NavigationPath = .init()
    @Published var showRecipeFormView: Bool = false
    
    init() {
        if let openURL = ProcessInfo.processInfo.environment["-openURL"] {
            separateURL(openURL)
        }
    }
    
    func separateURL(_ url: String) {
        let removedPrefixURL: String = url.replacingOccurrences(of: "cookcode://", with: "")
        let components = removedPrefixURL.components(separatedBy: "?")
        
        for component in components {
            if component.contains("tab=") {
                continue
            }
            
            if component.contains("outer=") {
                navigateOuter(component.replacingOccurrences(of: "outer=", with: ""))
            }
        }
    }
    
    private func navigateOuter(_ string: String) {
        switch string {
        case "recipe":
            showRecipeFormView = true
        default:
            break
        }
    }
    
    func dismissRecipeFormView() {
        showRecipeFormView = false
    }
    
}
