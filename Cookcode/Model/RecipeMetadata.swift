//
//  RecipeMetadata.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import Foundation

struct RecipeMetadata: Codable {
    var title: String = ""
    var description: String = ""
    var mainIngredients: [String] = []
    var optionalIngredients: [String] = [] 
}
