//
//  View + offset.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import Foundation
import SwiftUI


struct OffsetY: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetY(coordinateSpace: CoordinateSpace = .global, completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: coordinateSpace).minY
                    
                    Color.clear
                        .preference(key: OffsetY.self, value: minY)
                        .onPreferenceChange(OffsetY.self, perform: completion)
                }
            }
    }
    }
    
