//
//  IngredientForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation

struct IngredientForm {
    let ingredId: Int
    private var _expiredAt: Date = .now
    private var _quantity: String = ""
    
    var expiredAt: Date {
        get { _expiredAt }
        set(newValue) { _expiredAt = newValue }
    }
    
    var quantity: String {
        get { _quantity }
        set(newValue) { _quantity = newValue }
    }
    
    init(ingredId: Int) {
        self.ingredId = ingredId 
    }
    
    init(detail: IngredientDetail) {
        ingredId = detail.ingredId
        _expiredAt = detail.expiredAt
        _quantity = String(detail.quantity)
    }
}
