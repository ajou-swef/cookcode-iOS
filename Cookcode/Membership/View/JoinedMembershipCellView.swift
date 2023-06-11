//
//  JoinedMembershipView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct JoinedMembershipCellView<ViewModel: JoinedMembershipInteractable>: View {
    
    @ObservedObject var viewModel: ViewModel
    let membership: JoinedMembershipDetail
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    ProfileNavigateButton(userCell: membership.creater, width: 30)
                    Text("\(membership.creater.userName)")
                        .font(.custom(CustomFont.interRegular.rawValue, size: 20))
                }
                
                HStack {
                    Text("\(membership.grade): ₩\(membership.price)/월")
                        .font(.custom(CustomFont.interRegular.rawValue, size: 15))
                }
            }
            
            Spacer()
            
            Button {
                Task { await viewModel.joinedMembershipButtonTapped(membership)}
            } label: {
                Text("해지")
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 25)
                    .background {
                        Color.gray808080
                            .clipShape(Capsule())
                    }
            }

        }
    }
}

struct JoinedMembershipView_Previews: PreviewProvider {
    static var previews: some View {
        JoinedMembershipCellView(viewModel: JoineMembershipViewModel(),
                             membership: .mock())
    }
}
