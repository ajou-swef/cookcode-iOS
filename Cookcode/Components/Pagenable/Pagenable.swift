//
//  PagenableViewModel.swift
//  RefreshComponent
//
//  Created by 노우영 on 2023/05/29.
//

import SwiftUI
import cookcode_service

protocol Pagenable: ObservableObject {
    associatedtype Dto: Mock, Decodable
    associatedtype T
    
    var contents: [T] { get set }
    var pageState: PageState { get set }
    var fetchTriggerOffset: CGFloat { get set }
    var pageSize: Int { get } 
    func onFetch() async
    func appendCell(_ success: ServiceResponse<PageResponse<Dto>>)
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
    
    func controllPageState(_ response: ServiceResponse<PageResponse<Dto>>, _ curPage: Int) {
        if response.data.hasNext {
            waitInPage(curPage + 1)
        } else {
            pageState = .noRemain
        }
    }
    
    
    func waitInPage(_ page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageState = .wait(page)
        }
    }
}
