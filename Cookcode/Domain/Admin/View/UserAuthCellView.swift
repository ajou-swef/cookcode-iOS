//
//  UserAuthCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/12.
//

import SwiftUI
import Kingfisher

struct UserAuthCellView<ViewModel: UserAuthInteractable>: View {
    
    @ObservedObject var viewModel: ViewModel
    let userAuth: UserAuth
    
    var body: some View {
        HStack {
            Text("유저아이디: \(userAuth.userID)")
            Text("요청: \(userAuth.authority.rawValue)")
        }
        .swipeActions {
            Button {
                Task { await viewModel.userAuthOkButtonTapped(userAuth)}
            } label: {
                Text("승인")
            }
            
            Button {
                Task { await viewModel.userAuthCancelButtonTapped(userAuth) }
            } label: {
                Text("거부")
            }
        }
    }
}

struct UserAuthCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserAuthCellView(viewModel: TreatAuthRequestViewModel(), userAuth: .mock())
    }
}
