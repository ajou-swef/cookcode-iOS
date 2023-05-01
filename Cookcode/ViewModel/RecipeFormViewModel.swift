//
//  CreateRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PhotosUI

class RecipeFormViewModel: ObservableObject {
    
    private let recipeService: RecipeServiceProtocol
    private let contentService: ContentServiceProtocol
    
    @Published var recipeForm: RecipeForm = .init()
    
    @Published var mainImageItem: PhotosPickerItem?
    @Published var mainImageData: Data? 
    
    @Published var stepItems: [PhotosPickerItem] = .init()
    @Published var stepImageData: [Data] = .init()
    @Published var stepVideoURLs: [VideoURL] = .init()
    @Published var serviceAlert: ServiceAlert = .init()
    
    // sheet, fullscreen 등의 navigate를 위한 프로퍼티
    @Published var stepFormTrigger: RecipePathWithIndex?
    
    // step 작성 시의 tabSelection
    @Published var stepTabSelection: String = ""
    @Published var previewTabSelection: String = "main" 
    
    // alert
    @Published var isPresentedContentDeleteAlert: Bool = false
    
    // 부드러운 스텝 삭제 애니메이션을 위한 프로퍼티
    @Published var deletedStepIndex: Int?
    
    var recipeMetadataHasThumbnail: Bool {
        !recipeForm.thumbnailIsEmpty
    }
    
    var previewButtonIsAvailable: Bool {
        containsAnyStep && !recipeForm.titleIsEmpty && mainImageData != nil
    }
    
    var containsAnyStep: Bool {
        recipeForm.steps.count >= 1 
    }
    
    var trashButtonIsShowing: Bool {
        recipeForm.steps.count >= 2
    }
    
    init(_ preview: Bool = false, contentService: ContentServiceProtocol, recipeService: RecipeServiceProtocol) {
        
        self.contentService = contentService
        self.recipeService = recipeService
        
        if preview {
            recipeForm.appendStep(ContentWrappedStepForm())
        }
    }
    
    fileprivate func appendStepForm() {
        recipeForm.appendStep(ContentWrappedStepForm())
    }
    
    func stepFormContainsAllRequiredInformation(at: Int) -> Bool {
        recipeForm.steps[at].containsAllRequiredInformation
    }
    
    func stepFormTitle(at: Int) -> String {
        recipeForm.steps[at].title
    }
    
    func stepFormDescription(at: Int) -> String {
        recipeForm.steps[at].description
    }
    
    func stepFormContainsAnyContent(at: Int) -> Bool {
        recipeForm.steps[at].containsAnyContent
    }
    
    func stepFormContainsAnyImage(at: Int) -> Bool {
        recipeForm.steps[at].containsAnyImage
    }
    
    func stepFormContainsAnyVideoURL(at: Int) -> Bool {
        recipeForm.steps[at].containsAnyVideoURL
    }
    
    func stepFormContentType(at :Int) -> ContentType {
        recipeForm.steps[at].contentType
    }
    
    func stepFormID(at: Int) -> String {
        recipeForm.steps[at].id
    }
    
    //  MARK: StepView 관련 기능들
    func presentStepFormView(_ i: Int) {
        stepTabSelection = recipeForm.steps[i].id
        stepFormTrigger = RecipePathWithIndex(path: .step, index: i)
    }
    
    func flushDeletedStepIndex() {
        if let i = deletedStepIndex {
            recipeForm.removeStepAt(i)
        }
        
        deletedStepIndex = nil
    }
    
    //  MARK: UI 상호작용
    
    // 바로 삭제하지 않고 삭제될 Index를 저장한다. 바로 삭제하면 애니메이션이 이상해진다.
    // 삭제될 stepIndex를 저장한 후에 view disappear 시점에서 삭제한다. 
    func removeThisStep(_ i: Int) {
        withAnimation {
            stepTabSelection = recipeForm.steps[i-1].id
            deletedStepIndex = i
        }
    }
    
    func changeToImageButtonTapped(_ i: Int) {
        if recipeForm.steps[i].containsAnyVideoURL {
            isPresentedContentDeleteAlert = true
        } else {
            recipeForm.stepChangesContent(i)
        }
    }
    
    func changeContentTypeToVideo(_ i: Int) {
        if recipeForm.steps[i].containsAnyImage {
            isPresentedContentDeleteAlert = true
        } else {
            recipeForm.stepChangesContent(i)
        }
    }
    
    func deleteContentsButtonInAlertTapped(_ i: Int) {
        recipeForm.stepChangesContent(i)
    }
    
    func appendNewStepForm() {
        appendStepForm()
        withAnimation {
            if let last = recipeForm.steps.last {
                stepTabSelection = last.id
            }
        }
    }
    
    func addFirstStepButtonTapped() {
        appendStepForm()
        presentStepFormView(recipeForm.steps.count - 1)
    }
    
    func onDisappearStep() {
        flushDeletedStepIndex()
    }
    
    @MainActor
    func postMainImage() async {
        if let imageData = mainImageData {
            let result = await contentService.postPhotos([imageData])
            switch result {
            case .success(let success):
                recipeForm.updateThumbnail(url: success.url)
            case .failure(let failure):
                serviceAlert.presentAlert(failure)
            }
        }
    }
    
    @MainActor
    func loadItemAt(_ at: Int) async {
        let contentType = stepFormContentType(at: at)
        
        switch contentType {
        case .video:
            for item in stepItems {
                if let data = try? await item.loadTransferable(type: VideoURL.self) {
                    stepVideoURLs.append(data)
                }
            }
            
            let result = await contentService.postVideos([])
            switch result {
            case .success(let success):
                recipeForm.stepAppendContentURL(at, urls: success.data.photoURL)
            case .failure(let failure):
                serviceAlert.presentAlert(failure)
            }
            
        case .image:
            for item in stepItems {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    stepImageData.append(data)
                }
            }
            
            let result = await contentService.postPhotos(stepImageData)
            switch result {
            case .success(let success):
                recipeForm.stepAppendContentURL(at, urls: success.url)
            case .failure(let failure):
                serviceAlert.presentAlert(failure)
            }
        }
        
        stepItems.removeAll()
        stepImageData.removeAll()
        stepVideoURLs.removeAll()
    }
}
