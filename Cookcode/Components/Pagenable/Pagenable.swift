//
//  PagenableViewModel.swift
//  RefreshComponent
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI

protocol Pagenable: Refreshable {
    var pageState: PageState { get set }
    var fetchTriggerOffset: CGFloat { get set }
    func onFetch() async
}

extension Pagenable {
    var searchTriggerInScreen: Bool {
        fetchTriggerOffset <= UIScreen.main.bounds.maxY
    }

    var isLoadingState: Bool{
        pageState.isLoadingState
    }

    var isWaitingState: Bool {
        pageState.isWaitingState
    }
    
    func fetchNextPage() async {
        guard searchTriggerInScreen else { return }
        guard pageState.isWaitingState else { return }
        await onFetch()
    }
    
    func waitIn(_ curPage: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageState = .wait(curPage + 1)
        }
    }
}
