//
//  RefrigeratorView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

struct RefrigeratorView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundColor(.mainColor)
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("+ 추가")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .foregroundColor(.primary)
                }
            }

            
            ScrollView {
                VStack {
                    
                }
            }
        }
        .padding(.horizontal, 10)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("냉장고")
                    .font(CustomFontFactory.INTER_BOLD_30)
            }
        }
    }
}

struct RefrigeratorView_Previews: PreviewProvider {
    static var previews: some View {
        RefrigeratorView()
    }
}
