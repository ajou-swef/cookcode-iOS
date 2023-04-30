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
    @Published var outerPath: OuterPath?
    
    @Published var homePath: NavigationPath = .init()
    
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
                let rawValue = component.replacingOccurrences(of: "outer=", with: "")
                let outerPath = OuterPath(rawValue: rawValue)
                if let outerPath = outerPath {
                    navigateToOuter(outerPath)
                }
            }
        }
    }
    
    func navigateToOuter(_ path: OuterPath) {
        outerPath = path
    }
    
    func navigateWithHome(_ path: HomePath) {
        homePath.append(path)
    }
    
    func dismissRecipeFormView() {
        outerPath = nil
    }
    
}
