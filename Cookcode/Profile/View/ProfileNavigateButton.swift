//
//  ProfileNavigateButton.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/09.
//

import SwiftUI
import Kingfisher

struct ProfileNavigateButton: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    let userCell: UserCell
    let width: CGFloat
    
    var body: some View {
        Button {
            let homeIdPath = HomeIdPath(path: .profile, id: userCell.userId)
            navigateViewModel.navigateWithHome(homeIdPath)
        } label: {
            
            if let url = userCell.imageURL {
                KFImage(URL(string: url))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: width)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .frame(width: width)
            }
        }
    }
}

struct ProfileNavigateButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileNavigateButton(userCell: .mock(), width: 100)
    }
}
