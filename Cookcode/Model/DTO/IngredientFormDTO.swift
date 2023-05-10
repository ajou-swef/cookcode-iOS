//
//  IngredientFormDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/08.
//

import Foundation

struct IngredientFormDTO: Encodable {
    let ingredId: Int
    let expiredAt: String
    let quantity: Int
    
    init(form: IngredientForm) {
        ingredId = form.ingredId
        expiredAt = ServiceDateFormatter.tranlsateToString(form.expiredAt)
        quantity = Int(form.quantity) ?? -1
    }
}

