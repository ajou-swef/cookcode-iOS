//
//  IngredientType.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/08.
//

import Foundation

enum IngredientType: String, Identifiable, CaseIterable {
    
    case meat, seafood, vegetables, fruit, sauces
    case diaryProducts, rice
    
    
    init (fromRawValue: String) {
        self = IngredientType(rawValue: fromRawValue.lowercased()) ?? .seafood
    }
    
    var id: String {
        return self.rawValue
    }
    
    var korean: String {
        switch self {
            
        case .meat:
            return "고기"
        case .seafood:
            return "해산물"
        case .vegetables:
            return "채소"
        case .fruit:
            return "과일"
        case .sauces:
            return "소스"
        case .diaryProducts:
            return "유제품"
        case .rice:
            return "곡류"
        }
    }
}
