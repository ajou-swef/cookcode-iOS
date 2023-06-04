//
//  UserSearchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import SwiftUI

struct UserSearchView: View {
    
    @StateObject private var viewModel: UserSearchViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(accountService: AccountServiceProtocol = AccountService(),
         query: String) {
        self._viewModel = StateObject(wrappedValue: UserSearchViewModel(accountService: AccountSuccessService(), query: query))
    }
    
    var body: some View {
        RefreshComponent(viewModel: viewModel, spacing: 0) {
            PagenableComponent(viewModel: viewModel) {
                ForEach(viewModel.contents) { userCell in
                    Button {
                        let homeIdPath = HomeIdPath(path: .profile, id: userCell.userId)
                        navigateViewModel.navigateWithHome(homeIdPath)
                    } label: {
                        UserCellView(userCell: userCell)
                    }
                }
            }
        }
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView(accountService: AccountSuccessService(),
                       query: "쿼리")
    }
}
