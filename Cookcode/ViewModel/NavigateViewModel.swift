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
    @Published var homePath: NavigationPath = .init()
    
    @Published var outerPath: OuterPath?
    @Published var profilePath: NavigationPath = .init()
    
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
                let rawValue = component.replacingOccurrences(of: "tab=", with: "")
                let tab = Tab.convert(from: rawValue)
                if let tab = tab {
                    navigateWithTab(tab)
                }
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
    
    func navigateWithTab(_ tab: Tab) {
        self.tab = tab
    }
    
    func navigateWithProfile(_ path: any Hashable) {
        profilePath.append(path)
    }
    
    func navigateToOuter(_ path: OuterPath) {
        outerPath = path
    }
    
    func navigateWithHome(_ path: any Hashable) {
        homePath.append(path)
    }
    
    func dismissOuter() {
        outerPath = nil
    }
    
}
