//
//  RecipeCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import SwiftUI
import Kingfisher

struct CellView: View {
    
    let cell: any SearchedCell
    
    var body: some View {
        VStack(alignment: .center) {
            KFImage(URL(string: cell.thumbnail))
                .resizable()
                .startLoadingBeforeViewAppear()
                .aspectRatio(CGSize(width: 4, height: 2.5), contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .bottomTrailing) {
                    Text(cell.title)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.trailing, 10)
                        .font(CustomFontFactory.INTER_SEMIBOLD_20)
                }
            
            HStack(spacing: 5) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading) {
                    Text("\(cell.title)")
                        .lineLimit(1)
                        .font(CustomFontFactory.INTER_BOLD_16)
                    
                    HStack {
                        Text("\(cell.userName)")
                            .lineLimit(1)
                            .font(CustomFontFactory.INTER_REGULAR_14)
                            .foregroundColor(.primary)
                        
                        Text("\(cell.createdAt)")
                            .lineLimit(1)
                            .font(CustomFontFactory.INTER_REGULAR_14)
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct RecipeCellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cell: RecipeCell.mock())
    }
}
