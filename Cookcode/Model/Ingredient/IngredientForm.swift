//
//  IngredientForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation

struct IngredientForm {
    private let _id: Int
    private var _date: Date = .now
    private var _quantity: String = ""
    
    var date: Date {
        get { _date }
        set(newValue) { _date = newValue }
    }
    
    var quantity: String {
        get { _quantity }
        set(newValue) { _quantity = newValue }
    }
    
    init(id: Int) {
        _id = id 
    }
}
