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
    @Published var stepTabSelection: String = ""
    
    //  alert
    @Published var isPresentedContentDeleteAlert: Bool = false
    
    // 부드러운 스텝 삭제 애니메이션용
    @Published var deletedStepIndex: Int?
    
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
    
    fileprivate func appendStepForm() {
        stepForms.append(ContentWrappedStepForm())
    }
    
    //  MARK: StepView 관련 기능들
    func showStepFormView(_ i: Int) {
        stepTabSelection = stepForms[i].id
        stepFormTrigger = RecipePathWithIndex(path: .step, index: i)
    }
    
    func flushDeletedStepIndex() {
        if let i = deletedStepIndex {
            stepForms.remove(at: i)
        }
        
        deletedStepIndex = nil
    }
    
    //  MARK: UI 상호작용
    func trashButtonTapped(_ i: Int) {
        withAnimation {
            stepTabSelection = stepForms[i-1].id
            deletedStepIndex = i
        }
    }
    
    func changeToImageButtonTapped(_ i: Int) {
        if stepForms[i].containsAnyVideoURL {
            isPresentedContentDeleteAlert = true
        } else {
            stepForms[i].changeContent()
        }
    }
    
    func changeToVideoButtonTapped(_ i: Int) {
        if stepForms[i].containsAnyImage {
            isPresentedContentDeleteAlert = true
        } else {
            stepForms[i].changeContent()
        }
    }
    
    func deleteContentsButtonInAlertTapped(_ i: Int) {
        stepForms[i].changeContent()
    }
    
    func addStepButtonTapped() {
        appendStepForm()
        withAnimation {
            if let last = stepForms.last {
                stepTabSelection = last.id
            }
        }
    }
    
    func addFirstStepButtonTapped() {
        appendStepForm()
        showStepFormView(stepForms.count - 1)
    }
    
    func onDisappearStep() {
        flushDeletedStepIndex()
    }
}
