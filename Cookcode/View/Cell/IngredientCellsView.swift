//
//  IngredientCellsView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/16.
//

import SwiftUI

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
                IngredientCellView(cell: cell)
            }
        }
    }
}

struct IngredientCellsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCellsView(ingredientCells: IngredientCell.mocks(10))
    }
}
