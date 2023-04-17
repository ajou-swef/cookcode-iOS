//
//  View + Hidden.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/17.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hidden(_ hidden: Bool) -> some View {
        if !hidden {
            self
        }
    }
}
