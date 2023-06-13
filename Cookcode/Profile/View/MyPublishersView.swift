//
//  MyPublishersView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

struct MyPublishersView: View {
    
    @StateObject private var viewModel: MyPublisherViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(accountService: AccountServiceProtocol = AccountService()) {
        self._viewModel = StateObject(wrappedValue: MyPublisherViewModel(accountSerivce: accountService))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PagenableComponent(viewModel: viewModel) {
                    ForEach(viewModel.contents) { userProfileCell in
                        Button {
                            let id = userProfileCell.userId
                            let homeIdPath = HomeIdPath(path: .profile, id: id)
                            navigateViewModel.navigateWithHome(homeIdPath)
                        } label: {
                            UserCellView(userCell: userProfileCell)
                        }
                    }
                }
            }
            .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
                ViewAlert.cancelButton
            }
        }
        .navigationTitle("구독 목록")
    }
}

struct MyPublishersView_Previews: PreviewProvider {
    static var previews: some View {
        MyPublishersView(accountService: AccountSuccessService())
    }
}
