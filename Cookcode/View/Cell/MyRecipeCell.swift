//
//  MyRecipeCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import SwiftUI

struct MyRecipeCell: View {
    
    let recipeCell: RecipeCell
    
    var body: some View {
        Text("\(recipeCell.title)")
    }
}

struct MyRecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeCell(recipeCell: RecipeCell.Mock())
    }
}
