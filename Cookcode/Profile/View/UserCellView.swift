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
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            
            Text("\(userCell.userName)")
                .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
        }
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView(userCell: .mock())
    }
}
