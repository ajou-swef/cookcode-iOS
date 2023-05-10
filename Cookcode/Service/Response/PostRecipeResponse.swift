//
//  PostRecipeResponse.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Foundation

struct PostRecipeResonse: Codable, Mock {
    static func mock() -> PostRecipeResonse {
        PostRecipeResonse(recipeID: 1)
    }
    
    let recipeID: Int

   enum CodingKeys: String, CodingKey {
       case recipeID = "recipeId"
   }
}
