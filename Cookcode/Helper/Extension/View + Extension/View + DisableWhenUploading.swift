//
//  View + DisableWhenUploading.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func disableWhenUploading(_ trigger: Bool) -> some View {
        self
            .overlay {
                ZStack(alignment: .center) {
                    Color.grayBCBCBC.opacity(0.5)
                    ProgressView()
                }
                .hidden(!trigger)
                .ignoresSafeArea()
            }
            .disabled(trigger)
    }
}
