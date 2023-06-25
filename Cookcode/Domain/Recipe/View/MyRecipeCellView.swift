//
//  MyRecipeCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import SwiftUI

struct MyRecipeCellView: View {
    
    let recipeCell: RecipeCell
    
    var body: some View {
        Text("\(recipeCell.title)")
    }
}

struct MyRecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeCellView(recipeCell: RecipeCell.mock())
    }
}
