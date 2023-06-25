//
//  ManageAuthView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI

struct ManageAuthView: View {
    
    @StateObject private var viewModel = MembershipFormViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("멤버쉽 이름")
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 18))
                
                Spacer()
                
                TextField("입력하세요", text: $viewModel.membershipGrade.grade)
                    .multilineTextAlignment(.trailing)
            }
            
            Divider()
            
            HStack {
                Text("멤버쉽 가격")
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 18))
                
                TextField("입력하세요", text: $viewModel.membershipGrade.price)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            
            Spacer()
            
            PatchComponent(viewModel: viewModel, cellType: .none, id: -1)
        }
        .padding(.all)
    }
}

struct ManageAuthView_Previews: PreviewProvider {
    static var previews: some View {
        ManageAuthView()
    }
}
