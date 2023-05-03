//
//  IngredientCellView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import SwiftUI

struct IngredientCellView: View {
    
    let cell: IngredientCell
    
    var body: some View {
        VStack {
            Image(cell.thumbnail)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(cell.title)
                .foregroundColor(.primary)
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
        }
    }
}

struct IngredientCellView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCellView(cell: IngredientCell.Mock())
    }
}
