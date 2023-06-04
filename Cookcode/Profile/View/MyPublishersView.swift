//
//  MyPublishersView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

struct MyPublishersView: View {
    
    @StateObject private var viewModel: MyPublisherViewModel
    
    init(accountService: AccountServiceProtocol = AccountService()) {
        self._viewModel = StateObject(wrappedValue: MyPublisherViewModel(accountSerivce: accountService))
    }
    
    var body: some View {
        PagenableComponent(viewModel: viewModel) {
            ForEach(viewModel.contents) { userProfileCell in
                UserCellView(userCell: userProfileCell)
            }
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ServiceAlert.CANCEL_BUTTON
        }
    }
}

struct MyPublishersView_Previews: PreviewProvider {
    static var previews: some View {
        MyPublishersView(accountService: AccountSuccessService())
    }
}
