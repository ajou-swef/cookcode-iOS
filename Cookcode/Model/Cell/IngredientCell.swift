//
//  IngredientCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import Foundation

struct IngredientCell: Cell, Equatable {
    
    var id: String = UUID().uuidString
    
    var thumbnail: String
    var title: String
    
    static func Mock() -> IngredientCell {
        IngredientCell(thumbnail: "apple", title: "사과")
    }
    
    
}
