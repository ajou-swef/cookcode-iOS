//
//  Ingredient.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/07.
//

import Foundation

struct IngredientFactory {
    static func CELL(thunbnail: String, title: String) -> IngredientCell {
        IngredientCell(thumbnail: thunbnail, title: title)
    }
    
    static func FORM(id: Int) -> IngredientForm {
        IngredientForm(ingredId: id)
    }
}
