//
//  IngredientCellsView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/16.
//

import SwiftUI
import HidableTabView

struct IngredientCellsView: View {
    
    let ingredientCells: [IngredientCell]
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
    ]
    
    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(ingredientCells) { cell in
                NavigationLink {
                    let ingredient = INGREDIENTS_DICTIONARY[cell.ingredId]?.title ?? ""
                    MyWebView(urlToLoad: "https://m.coupang.com/nm/search?q=\(ingredient)")
                        .hideTabBar(animated: false)
                        
                } label: {
                    IngredientCellView(cell: cell)
                }
            }
        }
    }
}

struct IngredientCellsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCellsView(ingredientCells: IngredientCell.mocks(10))
    }
}
