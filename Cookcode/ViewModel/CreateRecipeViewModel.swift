//
//  CreateRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

class CreateRecipeViewModel: ObservableObject {
    @Published var recipeMetadata: RecipeMetadata = .init()
}
