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
    
    @Published var recipeMetadata: RecipeForm = .init()
    
    @Published var mainImageItem: PhotosPickerItem?
    @Published var mainImageData: Data? 
    
    @Published var stepItems: [PhotosPickerItem] = .init()
    @Published var stepImageData: [Data] = .init()
    
    @Published var stepForms: [ContentWrappedStepForm] = .init()
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
        !recipeMetadata.thumbnailIsEmpty
    }
    
    var previewButtonIsAvailable: Bool {
        containsAnyStep && !recipeMetadata.titleIsEmpty && mainImageData != nil
    }
    
    var containsAnyStep: Bool {
        stepForms.count >= 1 
    }
    
    var trashButtonIsShowing: Bool {
        stepForms.count >= 2
    }
    
    init(_ preview: Bool = false, contentService: ContentServiceProtocol, recipeService: RecipeServiceProtocol) {
        
        self.contentService = contentService
        self.recipeService = recipeService
        
        if preview {
            stepForms.append(ContentWrappedStepForm())
        }
    }
    
    fileprivate func appendStepForm() {
        stepForms.append(ContentWrappedStepForm())
    }
    
    func stepFormContainsAllRequiredInformation(at: Int) -> Bool {
        stepForms[at].containsAllRequiredInformation
    }
    
    func stepFormTitle(at: Int) -> String {
        stepForms[at].title
    }
    
    func stepFormDescription(at: Int) -> String {
        stepForms[at].description
    }
    
    func stepFormContainsAnyContent(at: Int) -> Bool {
        stepForms[at].containsAnyContent
    }
    
    func stepFormContainsAnyImage(at: Int) -> Bool {
        stepForms[at].containsAnyImage
    }
    
    func stepFormContainsAnyVideoURL(at: Int) -> Bool {
        stepForms[at].containsAnyVideoURL
    }
    
    func stepFormContentType(at :Int) -> ContentType {
        stepForms[at].contentType
    }
    
    func stepFormID(at: Int) -> String {
        stepForms[at].id
    }
    
    //  MARK: StepView 관련 기능들
    func presentStepFormView(_ i: Int) {
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
    
    // 바로 삭제하지 않고 삭제될 Index를 저장한다. 바로 삭제하면 애니메이션이 이상해진다.
    // 삭제될 stepIndex를 저장한 후에 view disappear 시점에서 삭제한다. 
    func removeThisStep(_ i: Int) {
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
    
    func changeContentTypeToVideo(_ i: Int) {
        if stepForms[i].containsAnyImage {
            isPresentedContentDeleteAlert = true
        } else {
            stepForms[i].changeContent()
        }
    }
    
    func deleteContentsButtonInAlertTapped(_ i: Int) {
        stepForms[i].changeContent()
    }
    
    func appendNewStepForm() {
        appendStepForm()
        withAnimation {
            if let last = stepForms.last {
                stepTabSelection = last.id
            }
        }
    }
    
    func addFirstStepButtonTapped() {
        appendStepForm()
        presentStepFormView(stepForms.count - 1)
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
                recipeMetadata.updateThumbnail(url: success.url)
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
            break
        case .image:
            for item in stepItems {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    stepImageData.append(data)
                }
            }
            
            let result = await contentService.postPhotos(stepImageData)
            switch result {
            case .success(let success):
                stepForms[at].imageURLs = success.data.photoURL
            case .failure(let failure):
                serviceAlert.presentAlert(failure)
            }
        }
        
        stepItems = .init()
        stepImageData = .init()
    }
}
