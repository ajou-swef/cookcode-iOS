//
//  IngredientCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import SwiftUI

struct IngredientCellView: View {
    
    let cell: IngredientCell
    let isVertical: Bool
    
    init (cell: IngredientCell, isVertical: Bool = true) {
        self.cell = cell
        self.isVertical = isVertical
    }
    
    var layout: AnyLayout {
        isVertical ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
    }
    
    var body: some View {
        
        layout {
            Image(cell.thumbnail)
                .resizable()
                .frame(width: 40, height: 40)
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.red)
                        .hidden(!cell.presentBadge)
                }
            
            Text(cell.title)
                .foregroundColor(.primary)
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
            
            Text("\(cell.quantity ?? 0)")
                .foregroundColor(.primary)
                .font(CustomFontFactory.INTER_REGULAR_14)
                .hidden(cell.quantityIsNil)
        }
    }
}

struct IngredientCellView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCellView(cell: IngredientCell.Mock())
    }
}
