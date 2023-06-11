//
//  JoineMembershipList.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct JoineMembershipList: View {
    
    @StateObject private var viewModel = JoineMembershipViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.memberships) { membership in
                    JoinedMembershipCellView(viewModel: viewModel, membership: membership)
                }
            }
        }
    }
}

struct JoineMembershipList_Previews: PreviewProvider {
    static var previews: some View {
        JoineMembershipList()
    }
}
