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
    var quantity: Int?
    
    var quantityIsNil: Bool {
        quantity == nil 
    }
    
    static func Mock() -> IngredientCell {
        IngredientCell(thumbnail: "apple", title: "사과")
    }
    
    init(thumbnail: String, title: String) {
        self.thumbnail = thumbnail
        self.title = title
    }
    
    init (dto: IngredientCellDto) {
        self.title = dto.name
        let ingID = dto.ingredId
        
        self.id = String("\(ingID)")
        self.thumbnail = INGREDIENTS_DICTIONARY[ingID]?.thumbnail ?? "apple"
        self.quantity = dto.quantity
    }
}
