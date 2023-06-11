//
//  MySubscriberView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import SwiftUI

struct MySubscriberView: View {
    
    @StateObject private var viewModel: MySubscriberViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(accountService: AccountServiceProtocol = AccountService()) {
        self._viewModel = StateObject(wrappedValue: MySubscriberViewModel(accountSerivce: accountService))
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
            .frame(maxWidth: .infinity)
            .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
                ServiceAlert.cancelButton
            }
        }
        .navigationTitle("내 구독자")
    }
}

struct MySubscriberView_Previews: PreviewProvider {
    static var previews: some View {
        MySubscriberView(accountService: AccountSuccessService())
    }
}
