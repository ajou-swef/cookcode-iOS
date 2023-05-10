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
    var ingredId: Int
    
    private(set) var quantity: Int?
    private(set) var presentBadge: Bool = false

    var quantityIsNil: Bool {
        quantity == nil 
    }
    
    static func mock() -> IngredientCell {
        IngredientCell(detail: IngredientDetail.mock())
    }
    
    init (thumbnail: String, title: String, ingredId: Int) {
        self.thumbnail = thumbnail
        self.title = title
        self.ingredId = ingredId
    }
    
    init (detail: IngredientDetail) {
        let ingredientCell = INGREDIENTS_DICTIONARY[detail.ingredId] ?? IngredientCell.mock()
        title = ingredientCell.title
        thumbnail = ingredientCell.thumbnail
        id = String(detail.fridgeIngredId)
        ingredId = detail.ingredId
        
        if expiredDateIsComming(ServiceDateFormatter.tranlsateToString(detail.expiredAt)) {
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
