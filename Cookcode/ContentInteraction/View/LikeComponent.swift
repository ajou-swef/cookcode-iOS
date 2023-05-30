//
//  LikeComponent.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/30.
//

import SwiftUI

struct LikeComponent: View {
    
    @State private var likes: Bool = false
    private let likeService: LikeServiceProtocol
    let contentId: Int
    
    init(likes: Bool, likeService: LikeServiceProtocol, contentId: Int) {
        self.likeService = likeService
        self.contentId = contentId
        self.likes = likes
    }
    
    var body: some View {
        Button {
            likes.toggle()
        } label: {
            Image(systemName: likes ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(CGSize(width: 4, height: 3.5), contentMode: .fit)
                .frame(width: 30)
                .foregroundColor(.white)
        }
    }
    
    func likeButtonTapped() async {
        let _ = await likeService.likesContentById(contentId)
    }
}

//struct LikeComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        LikeComponent()
//    }
//}
