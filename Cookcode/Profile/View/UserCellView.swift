//
//  UserCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct UserCellView: View {
    
    let userCell: UserCell
    
    var body: some View {
        HStack {
            if let url = userCell.imageURL {
                KFImage(URL(string: url))
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.horizontal, 60)
            }
            
            VStack(alignment: .leading) {
                Text("\(userCell.userName)")
                    .font(.custom(CustomFont.interBold.rawValue, size: 15))
                
                Text("구독자 \(userCell.subscriberCount)명")
                    .font(.custom(CustomFont.interRegular.rawValue, size: 13))
                    .foregroundColor(.gray808080)
                
                Text("email \(userCell.email)")
                    .font(.custom(CustomFont.interRegular.rawValue, size: 13))
                    .foregroundColor(.gray808080)
            }
            
            Spacer()
        }
        .padding(.vertical)
        .overlay {
            Rectangle()
                .stroke(lineWidth: 1)
                .foregroundColor(.gray_bcbcbc)
        }
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView(accountService: AccountSuccessService(),
                       query: "쿼리")
    }
}
