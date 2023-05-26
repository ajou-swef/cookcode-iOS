//
//  View + PresentIf.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func presentIf(_ isPresented: Bool) -> some View {
        if isPresented {
            self
        }
    }
}
