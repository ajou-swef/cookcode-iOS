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
    
    @Published var stepForms: [ContentWrappedStepForm] = .init()
    
    // sheet, fullscreen을 위한 프로퍼티
    @Published var stepFormTrigger: RecipePathWithIndex?
    @Published var isShowingPreviewView: Bool = false
    
    // step 작성 시의 tabSelection
    @Published var stepTabSelection: Int = 0
    
    var isAvailablePreviewButton: Bool {
        containsAnyStep && !recipeMetadata.isEmptyTitle && mainImageData != nil
    }
    
    var containsAnyStep: Bool {
        stepForms.count >= 1 
    }
    
    var isRemovableStep: Bool {
        stepForms.count >= 2
    }
    
    init(_ preview: Bool = false) {
        if preview {
            stepForms.append(ContentWrappedStepForm())
        }
    }
    
    func showStepFormView(_ index: Int) {
        stepFormTrigger = RecipePathWithIndex(path: .step, index: index)
    }
    
    func trashButtonTapped(_ index: Int) {
        stepForms.remove(at: index)
    }
    
    fileprivate func appendStepForm() {
        stepForms.append(ContentWrappedStepForm())
    }
    
    func addStepButtonTapped() {
        appendStepForm()
        
        withAnimation {
            stepTabSelection = stepForms.count - 1
        }
    }
    
    func addFirstStepButtonTapped() {
        appendStepForm()
        
        if stepForms.count >= 0 {
            showStepFormView(0)
            stepTabSelection = 0
        }
    }
    
    
}
