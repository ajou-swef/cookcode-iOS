//
//  View + offset.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import Foundation
import SwiftUI


struct OffsetKey: PreferenceKey {
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
    
    static var defaultValue: CGRect = .zero
}

struct OffsetYKey: PreferenceKey {
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
                        .preference(key: OffsetYKey.self, value: minY)
                        .onPreferenceChange(OffsetYKey.self, perform: completion)
                }
            }
    }
    
    @ViewBuilder
    func offsetX(_ addObserver: Bool, completion: @escaping (CGRect) -> Void) -> some View {
        self
            .frame(maxWidth: .infinity)
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion )
                    }
                }
            }
    }
}



