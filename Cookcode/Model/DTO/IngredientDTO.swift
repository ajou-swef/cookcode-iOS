//
//  IngredientDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct IngredientDTO: Codable, Mock, Hashable {
    static func mock() -> IngredientDTO {
        IngredientDTO(ingredientID: 1, name: "돼지고기", isLack: Bool.random())
    }
    
    
    
    let ingredientID: Int
    let name: String
    let isLack: Bool

      enum CodingKeys: String, CodingKey {
          case ingredientID = "ingredientId"
          case name, isLack
      }
}
