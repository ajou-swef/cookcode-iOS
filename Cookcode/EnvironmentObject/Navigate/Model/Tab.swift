//
//  Tab.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

enum Tab: String, CaseIterable, Equatable {
    case cookie = "Cookie"
    case home = "Home"
    case refrigerator = "Refrigerator"
    
    func selectImage(_ tab: Tab) -> Image {
        if self.rawValue == tab.rawValue {
            return selectedImage
        } else {
            return unselectedImage
        }
    }
    
    var unselectedImage: Image {
        switch self {
        case .cookie:
            return Image("cookie")
        case .home:
            return Image("home")
        case .refrigerator:
            return Image("refrigerator")
        }
    }
    
    var selectedImage: Image {
        switch self {
        case .cookie:
            return Image("cookie.fill")
        case .home:
            return Image("home.fill")
        case .refrigerator:
            return Image("refrigerator.fill")
        }
    }
    
    
    static func convert(from: String) -> Self? {
        return Tab.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
