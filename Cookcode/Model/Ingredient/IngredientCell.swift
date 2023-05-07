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
    
    private(set) var quantity: Int?
    private(set) var presentBadge: Bool = false

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
        self.thumbnail = INGREDIENTS_DICTIONARY[ingID]?.thumbnail ?? "apple"
        self.quantity = dto.quantity
        
        if expiredDateIsComming(dto._expiredAt) {
            presentBadge = true
        }
    }
    
    private func expiredDateIsComming(_ expiredAt: String) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date.now
        let expriedDate = dateFormatter.date(from: expiredAt) ?? .now
        let diffDay = Calendar.current.dateComponents([.day], from: expriedDate, to: today).day ?? 0
        
        if diffDay <= 2 {
            return true
        }
        return false
    }
}
