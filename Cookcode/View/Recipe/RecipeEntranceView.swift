//
//  RecipeEntranceView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI
import Kingfisher

struct RecipeEntranceView: View {
    
    let recipeDetail: RecipeDetail
    let cgSize: CGSize
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                KFImage(URL(string: recipeDetail.thumbnail))
                    .resizable()
                    .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                    .frame(maxWidth:. infinity, maxHeight: 300)
                
                Group {
                    Text(recipeDetail.title)
                        .font(CustomFontFactory.INTER_SEMIBOLD_20)
                        .padding(.bottom, 10)
                    
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
    }
}

//struct RecipeEntranceView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeEntranceView(recipeForm: <#RecipeForm#>, imageData: <#Data#>)
//    }
//}
