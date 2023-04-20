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
    @Published var stepSelction: Int = 0

    
    var isRemovableStep: Bool {
        stepForms.count >= 2
    }
    
    init(_ preview: Bool = false) {
        if preview {
            stepForms.append(StepForm())
        }
    }
    
    func showStepFormView(_ index: Int) {
        stepFormTrigger = RecipePathWithIndex(path: .step, index: index)
    }
    
    func trashButtonTapped(_ index: Int) {
        stepForms.remove(at: index)
    }
    
    fileprivate func appendStepForm() {
        stepForms.append(StepForm())
    }
    
    func addStepButotnTapped() {
        appendStepForm()
        
        withAnimation {
            stepSelction = stepForms.count - 1
        }
    }
    
    func addFirstStepButtonTapped() {
        appendStepForm()
        
        if stepForms.count >= 0 {
            showStepFormView(0)
            stepSelction = 0
        }
    }
}
