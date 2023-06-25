//
//  RecipeCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import SwiftUI
import Kingfisher

struct RecipeCellView: View {
    
    let cell: RecipeCell
    
    var body: some View {
        VStack(alignment: .center) {
            KFImage(URL(string: cell.thumbnail))
                .resizable()
                .startLoadingBeforeViewAppear()
                .aspectRatio(CGSize(width: 4, height: 2.5), contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack(spacing: 5) {
                ProfileNavigateButton(userCell: cell.userCell, width: 30)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("\(cell.title)")
                            .lineLimit(1)
                            .font(CustomFontFactory.INTER_BOLD_16)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.mainColor)
                            .presentIf(cell.isCookable)
                        
                        Text("요리하자")
                            .lineLimit(1)
                            .font(CustomFontFactory.INTER_REGULAR_14)
                            .presentIf(cell.isCookable)
                            .foregroundColor(.mainColor)
                    }
                    
                    HStack {
                        Text(cell.userCell.userName)
                            .lineLimit(1)
                            .font(CustomFontFactory.INTER_REGULAR_14)
                             
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 4, height: 4)
                        
                        Text("좋아요 \(cell.likesCount)")
                            .font(CustomFontFactory.INTER_REGULAR_14)
                        
                        
                        Spacer()
                        
                        Text("\(cell.createdAt)")
                            .lineLimit(1)
                            .font(CustomFontFactory.INTER_REGULAR_14)
                    }
                    .foregroundColor(.gray808080)
                }
                
                Spacer()
            }
        }
    }
}

struct RecipeCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCellView(cell: RecipeCell.mock())
    }
}
