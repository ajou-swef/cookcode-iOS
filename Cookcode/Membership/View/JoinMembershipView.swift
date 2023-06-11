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
            VStack {
                ForEach(viewModel.membershipGrades) { grade in
                    MembershipCellView(viewModel: viewModel, membershipGradeDetail: grade)
                }
            }
        }
    }
}

struct MembershipGradeView_Previews: PreviewProvider {
    static var previews: some View {
        JoinMembershipView(id: 1)
    }
}
