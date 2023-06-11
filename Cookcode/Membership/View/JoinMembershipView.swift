//
//  MembershipGradeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct JoinMembershipView: View {
    
    @StateObject private var viewModel: JoinMembershipViewModel
    
    init(id: Int) {
        self._viewModel = StateObject(wrappedValue: JoinMembershipViewModel(userId: id))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("멤버십 가입")
                    .font(.custom(CustomFont.interBold.rawValue, size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(viewModel.membershipGrades) { grade in
                    MembershipCellView(viewModel: viewModel, membershipGradeDetail: grade)
                }
            }
            .padding(.top)
            .padding(.horizontal)
        }
        .navigationBarTitle("멤버십 목록")
    }
}

struct MembershipGradeView_Previews: PreviewProvider {
    static var previews: some View {
        JoinMembershipView(id: 1)
    }
}
