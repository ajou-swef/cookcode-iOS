//
//  MembershipCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct MembershipCellView<ViewModel: MembershipGradeInteractable>: View {
    
    @ObservedObject var viewModel: ViewModel
    let membershipGradeDetail: MembershipGradeDetail
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(membershipGradeDetail.grade)
                    .font(.custom(CustomFont.interRegular.rawValue, size: 20))
                
                Text("₩\(membershipGradeDetail.price)/월")
                    .font(.custom(CustomFont.interRegular.rawValue, size: 15))
            }
            
            Spacer()
            
            Button {
                viewModel.membershipGradeButtonTapped(membershipGradeDetail)
            } label: {
                Text("가입")
                    .font(.custom(CustomFont.interRegular.rawValue, size: 15))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 25)
                    .background {
                        Capsule()
                            .foregroundColor(.mainColor)
                    }
            }

        }
    }
}

struct MembershipCellView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipCellView(viewModel: JoinMembershipViewModel(userId: 1), membershipGradeDetail: .mock())
    }
}
