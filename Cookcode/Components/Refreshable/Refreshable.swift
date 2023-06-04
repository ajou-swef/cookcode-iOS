//
//  RefreshViewModel.swift
//  RefreshComponent
//
//  Created by 노우영 on 2023/05/21.
//

import SwiftUI


protocol Refreshable: ObservableObject {
    var refreshThreshold: CGFloat { get }
    var dragVelocity: CGFloat { get set }
    var scrollOffset: CGFloat { get set }
    var rotatingDegree: Double { get }
    var componentOpacity: CGFloat { get }
    var spaceName: String { get }
    
    func onRefresh() async
}

extension Refreshable {
    var rotatingDegree: Double {
        Double(scrollOffset) * 4
    }
    
    var componentOpacity: CGFloat {
        scrollOffset - refreshThreshold
    }
    
    func refreshIfPossible() async {
        if scrollOffset >= refreshThreshold && dragVelocity <= 0 {
            await onRefresh()
        }
    }
}
