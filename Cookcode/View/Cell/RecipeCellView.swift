//
//  RecipeCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import SwiftUI
import Kingfisher

struct RecipeCellView: View {
    
    let recipeCell: RecipeCell
    let offsetY: CGFloat
    
    var body: some View {
        
        VStack(alignment: .center) {
            KFImage(URL(string: recipeCell.thumbanil))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .bottom) {
                    Text(recipeCell.title)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(.gray_bcbcbc)
                                }
                                .padding(.horizontal, 10)
                        }
                        .offset(y: offsetY)
                }
        }
    }
}

//struct RecipeCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeCellView(imageURL: "https://picsum.photos/seed/picsum/200/300")
//    }
//}
