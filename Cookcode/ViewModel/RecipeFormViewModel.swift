//
//  CreateRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PhotosUI

class RecipeFormViewModel: ObservableObject {
    @Published var recipeMetadata: RecipeForm = .init()
    @Published var mainImageItem: PhotosPickerItem?
    @Published var mainImageData: Data? 
    
    @Published var stepFormTrigger: RecipePathWithIndex?
    
    @Published var stepForms: [StepForm] = .init()
    
    func showStepFormView(_ index: Int) {
        stepFormTrigger = RecipePathWithIndex(path: .step, index: index)
    }
    
    func addStepButtonTapped() {
        stepForms.append(StepForm())
        
        if stepForms.count >= 0 {
            showStepFormView(0)
        }
    }
}
