//
//  IngredientDetail.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/08.
//

import Foundation
import cookcode_service

struct IngredientDetail: Identifiable, Mock {
    static func mock() -> IngredientDetail {
        IngredientDetail(dto: IngredientDetailDTO.mock())
    }
    
    let id: String = UUID().uuidString
    private let _fridgeIngredId, _ingredId: Int
    private var _expiredAt: Date
    private var _quantity: Int
    
    var quantity: Int {
        get { _quantity }
        set(newValue) { _quantity = newValue }
    }
    
    var expiredAt: Date {
        get { _expiredAt }
        set(newValue) { _expiredAt = newValue }
    }
    
    var fridgeIngredId: Int {
        _fridgeIngredId
    }
    
    var ingredId: Int {
        _ingredId
    }
    
    
    init(dto: IngredientDetailDTO) {
        _fridgeIngredId = dto.fridgeIngredId
        _ingredId = dto.ingredId
        _quantity = dto.quantity
        _expiredAt = ServiceDateFormatter.translateToDate(dto._expiredAt)
    }
}
