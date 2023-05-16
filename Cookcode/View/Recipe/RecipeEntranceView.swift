//
//  RecipeEntranceView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI
import Kingfisher

struct RecipeEntranceView: View {
    
    @State private var offset: CGFloat = .zero
    
    let recipeDetail: RecipeDetail
    let cgSize: CGSize
    private let defaultHeight: CGFloat = 300
    
    var height: CGFloat {
        return offset > 0 ? min(offset * 4 + defaultHeight, 600) : defaultHeight
    }
    
    var imageOffset: CGFloat {
        offset > 0 ? -offset : 0
    }
    
    var titleOpacity: CGFloat {
        offset > 0 ? (20 - offset) * 0.05 : 1
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                KFImage(URL(string: recipeDetail.thumbnail))
                    .resizable()
                    .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                    .frame(maxWidth:. infinity, minHeight: height)
                    .offset(y: imageOffset)
                    .offsetY(coordinateSpace: .named("entranceView")) {
                        offset = $0
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Text(recipeDetail.title)
                            .font(CustomFontFactory.INTER_SEMIBOLD_20)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing)
                            .opacity(titleOpacity)
                    }
                  
                Group {
                    Section {
                        Text(recipeDetail.description)
                            .font(CustomFontFactory.INTER_REGULAR_14)
                    } header: {
                        Text("설명")
                            .font(CustomFontFactory.INTER_SEMIBOLD_14)
                            .padding(.bottom, 10)
                    }
                    
                    Text("주 재료")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .padding(.top, 15)
                    
                    IngredientCellsView(ingredientCells: recipeDetail.ingredientCells)
                    
                    Text("추가 재료")
                        .font(CustomFontFactory.INTER_SEMIBOLD_14)
                        .padding(.top, 15)
                    
                    IngredientCellsView(ingredientCells: recipeDetail.optionalIngredientCells)
                }
                .padding(.horizontal, 10)
            }
        }
        .coordinateSpace(name: "entranceView")
    }
}

//struct RecipeEntranceView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEntranceView(recipeForm: <#RecipeForm#>, imageData: <#Data#>)
//    }
//}
