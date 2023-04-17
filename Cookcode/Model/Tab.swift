//
//  Tab.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case cookie = "Cookie"
    case home = "Home"
    case refrigerator = "Refrigerator"
    
    var image: Image {
        switch self {
        case .cookie:
            return Image("cookie")
        case .home:
            return Image(systemName: "apple.logo")
        case .refrigerator:
            return Image(systemName: "apple.logo")
        }
    }
    
    var filledImage: Image {
        switch self {
        case .cookie:
            return Image("cookie.fill")
        case .home:
            return Image(systemName: "apple.logo")
        case .refrigerator:
            return Image(systemName: "apple.logo")
        }
    }
    
    
    static func convert(from: String) -> Self? {
        return Tab.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
