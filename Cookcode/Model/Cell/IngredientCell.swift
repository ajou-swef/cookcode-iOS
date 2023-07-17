//
//  IngredientCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import cookcode_service
import Foundation

struct IngredientCell: Cell, Equatable {
    var id: String = UUID().uuidString
    
    var thumbnail: String
    var title: String
    var ingredId: Int
    var ingredientType: IngredientType
    
    private(set) var quantity: Int?
    private(set) var presentBadge: Bool = false

    var quantityIsNil: Bool {
        quantity == nil 
    }
    
    static func mock() -> IngredientCell {
        IngredientCell(detail: IngredientDetail.mock())
    }
    
    init (thumbnail: String, title: String, ingredId: Int, ingredientType: IngredientType) {
        self.thumbnail = thumbnail
        self.title = title
        self.ingredId = ingredId
        self.ingredientType = ingredientType
    }
    
    private func expiredDateIsComming(_ expiredAt: String) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date.now
        let expriedDate = dateFormatter.date(from: expiredAt) ?? .now
        let diffDay = Calendar.current.dateComponents([.day], from: today, to: expriedDate).day ?? 0
        
        if diffDay <= 2 {
            return true
        }
        
        return false
    }
}

extension IngredientCell {
    init (ingredientDTO: IngredientDTO) {
        let ingredientCell = INGREDIENTS_DICTIONARY[ingredientDTO.ingredientID] ?? IngredientCell.mock()
        self = ingredientCell
        presentBadge = ingredientDTO.isLack
    }
    
    init (detail: IngredientDetail) {
        let ingredientCell = INGREDIENTS_DICTIONARY[detail.ingredId] ?? IngredientCell.mock()
        self = ingredientCell
        id = String(detail.fridgeIngredId)
        
        if expiredDateIsComming(ServiceDateFormatter.tranlsateToString(detail.expiredAt)) {
            presentBadge = true
        }
    }
    
    init (ingredientId: Int) {
        let ingredientCell = INGREDIENTS_DICTIONARY[ingredientId] ?? IngredientCell.mock()
        self = ingredientCell
    }
}
