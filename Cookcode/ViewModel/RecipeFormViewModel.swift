//
//  CreateRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI

class RecipeFormViewModel: ObservableObject {
    @Published var recipeMetadata: RecipeForm = .init()
    @Published var stepForms: [StepForm] = .init()
    
    func addStepButtonTapped() {
        stepForms.append(StepForm())
    }
}
