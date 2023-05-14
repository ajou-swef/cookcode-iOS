//
//  Proxy.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation
import SwiftUI

struct MinY: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
