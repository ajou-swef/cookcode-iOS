//
//  IngredientForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation

struct IngredientForm {
    private let _id: Int
    var date: Date = .now
    var quantity: String = ""
    
    init(id: Int) {
        _id = id 
    }
}
