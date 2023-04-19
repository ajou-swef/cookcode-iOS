//
//  NavigateViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

class NavigateViewModel: ObservableObject {
    @Published var tab: Tab = .home
    @Published var isPresentedSlide: Bool = false
}
