//
//  MembershipView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/03/05.
//

import SwiftUI

struct MembershipView: View {
    var body: some View {
        VStack {
            Text("회원가입 화면")
        }
        .accessibilityIdentifier("MebershipView")
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
}
