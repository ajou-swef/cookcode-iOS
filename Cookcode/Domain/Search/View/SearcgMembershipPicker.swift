//
//  SearcgMembershipPicker.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/12.
//

import SwiftUI
import cookcode_service

struct SearcgMembershipPicker: View {
    
    @Binding var searchMembership: SearchMembershipType
    let searchMembershipTypes = SearchMembershipType.allCases
    
    
    var body: some View {
        HStack {
            ForEach(searchMembershipTypes) { type in
                Button {
                    searchMembership = type
                } label: {
                    Text(type.text)
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                }
                .foregroundColor(type == searchMembership ? .white : .mainColor)
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background {
                    if searchMembership == type {
                        Capsule()
                            .foregroundColor(.mainColor)
                    } else {
                        Capsule()
                            .stroke(lineWidth: 1)
                            .foregroundColor(.mainColor)
                    }
                }

            }
        }
    }
}

struct SearcgMembershipPicker_Previews: PreviewProvider {
    static var previews: some View {
        SearcgMembershipPicker(searchMembership: .constant(.subscribe))
    }
}
