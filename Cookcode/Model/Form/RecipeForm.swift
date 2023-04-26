//
//  RecipeMetadata.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import Foundation
import PhotosUI

struct RecipeForm: Codable {
    var title: String = ""
    var description: String = ""
    var mainIngredients: [String] = []
    var optionalIngredients: [String] = []
    
    var isEmptyTitle: Bool {
        title.isEmpty
    }
}
