//
//  CreateRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PhotosUI

class RecipeFormViewModel: RecipeViewModel, SelectIngredientViewModel, PatchViewModel {
    
    
    private(set) var recipeId: Int?
    
    var usePost: Bool {
        recipeId == nil
    }
    
    @Published var searchText: String = ""
    
    private let contentService: ContentServiceProtocol
    
    @Published var recipeForm: RecipeForm = RecipeForm() {
        willSet(newVal) {
            recipeDetail = RecipeDetail(form: newVal)
        }
    }
    
    @Published var useMainIngredient: Bool = false
    @Published var stepItems: [PhotosPickerItem] = .init()
    @Published var stepImageData: [Data] = .init()
    @Published var stepVideoURLs: [VideoURL] = .init()
    
    // sheet, fullscreen 등의 navigate를 위한 프로퍼티
    @Published var stepFormTrigger: RecipePathWithIndex?
    @Published var previewStepFormTrigger: RecipePathWithIndex?
    @Published var mainIngredientViewIsPresnted: Bool = false
    @Published var optioanlIngredientViewIsPresnted: Bool = false

    
    // step 작성 시의 tabSelection
    @Published var stepTabSelection: String = ""
    
    // alert
    @Published var isPresentedContentDeleteAlert: Bool = false
    
    // 부드러운 스텝 삭제 애니메이션을 위한 프로퍼티
    @Published var deletedStepIndex: Int?
    
    var mainButtonText: String {
        "스텝 추가하기"
    }
    
    var useTrashButton: Bool {
        recipeForm.steps.count >= 2
    }
    
    var deleteAlertIsPresented: Bool = false
    
    var recipeMetadataHasThumbnail: Bool {
        !recipeForm.thumbnail.isEmpty
    }
    
    var previewButtonIsDisabled: Bool {
        recipeForm.anyRequiredInformationIsEmpty
    }
    
    var containsAnyStep: Bool {
        recipeForm.steps.count >= 1 
    }
    
    var trashButtonIsShowing: Bool {
        recipeForm.steps.count >= 2
    }
    
    
    init(_ preview: Bool = false, contentService: ContentServiceProtocol, recipeService: RecipeServiceProtocol, recipeId: Int?) {
        self.contentService = contentService
        super.init(recipeService: recipeService, contentService: contentService, recipeID: nil)
        
        
        if preview {
            recipeForm.appendStep(ContentWrappedStepForm())
        }
        
        if let recipeId = recipeId {
            self.recipeId = recipeId
            Task {
                await fetchForm(recipeId: recipeId)
            }
        }
    }
    
    @MainActor
    private func fetchForm(recipeId: Int) async {
        let result = await recipeService.searchRecipe(recipeId)
        switch result {
        case .success(let success):
            recipeForm = RecipeForm(recipeDetailDTO: success.data)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
    
    func isNotSelected(_ ingredientID: Int) -> Bool {
        if useMainIngredient {
            return !recipeForm.ingredients.contains { id in id == ingredientID }
        } else {
            return !recipeForm.optionalIngredients.contains { id in id == ingredientID }
        }
    }
    
    fileprivate func controllMainIngredient(_ ingredientID: Int) {
        if let index = recipeForm.ingredients.firstIndex(of: ingredientID) {
            recipeForm.ingredients.remove(at: index)
        } else {
            recipeForm.ingredients.append(ingredientID)
        }
    }
    
    fileprivate func controllOptionalIngredient(_ ingredientID: Int) {
        if let index = recipeForm.optionalIngredients.firstIndex(of: ingredientID) {
            recipeForm.optionalIngredients.remove(at: index)
        } else {
            recipeForm.optionalIngredients.append(ingredientID)
        }
    }
    
    func ingredientCellTapped(_ ingredientID: Int) {
        if useMainIngredient {
            controllMainIngredient(ingredientID)
        } else {
            controllOptionalIngredient(ingredientID)
        }
    }
    
    fileprivate func appendStepForm() {
        recipeForm.appendStep(ContentWrappedStepForm())
    }
    
    func stepFormContainsAllRequiredInformation(at: Int) -> Bool {
        recipeForm.steps[at].containsAllRequiredInformation
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
    
    func stepFormContentType(at : Int) -> ContentType {
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
    
    func presentStepFormView() {
        guard let index = recipeDetail.steps.firstIndex(where: { $0.id == tabSelection }) else {
            return
        }
        
        stepTabSelection = recipeForm.steps[index].id
        previewStepFormTrigger = RecipePathWithIndex(path: .step, index: index)
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
    
    func postMainImage() async {
        guard let imageData = try? await recipeForm.photosPickerItem?.loadTransferable(type: Data.self) else { return }
        
        let result = await contentService.postPhotos([imageData])
        
        switch result {
        case .success(let response):
            await updateMainImage(response)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
        
    }
    
    @MainActor
    func updateMainImage(_ response: ServiceResponse<ContentDTO>) {
        guard let firstURL = response.data.urls.first else { return }
        recipeForm.updateThumbnail(url: firstURL)
    }
    
    @MainActor
    func loadItemAt(_ at: Int) async {
        if let index = recipeForm.steps.firstIndex(where: {  $0.id == stepTabSelection }) {
            let contentType = stepFormContentType(at: index)
            
            print("\(index+1) 번째 이미지 변경")
            
            switch contentType {
            case .video:
                for item in stepItems {
                    if let data = try? await item.loadTransferable(type: VideoURL.self) {
                        stepVideoURLs.append(data)
                    }
                }
                
                stepItems.removeAll()
                
                let result = await contentService.postVideos(stepVideoURLs)
                switch result {
                case .success(let success):
                    recipeForm.stepAppendContentURL(index, urls: success.data.urls)
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
                    recipeForm.steps[index].imageURLs = success.data.urls
                case .failure(let failure):
                    serviceAlert.presentAlert(failure)
                }
            }
        }
        
        stepItems.removeAll()
        stepImageData.removeAll()
        stepVideoURLs.removeAll()
    }
    
    @MainActor
    func mainButtonTapped(dismissAction: DismissAction) async {
        appendNewStepForm()
    }
    
    func trashButtonTapped() {
        for i in recipeForm.steps.indices {
            if recipeForm.steps[i].id == stepTabSelection {
                if i != 0 {
                    removeThisStep(i)
                }
            }
        }
    }
    
    func deleteOkButtonTapped(dismissAction: DismissAction) async {
        print("123")
    }
    
    @MainActor
    func uploadButtonTapped(completion: () -> ()) async {
        
        guard !recipeForm.anyStepLacksOfInformation else {
            serviceAlert.presentAlert(title: "정보가 부족한 스텝이 있습니다.")
            return
        }
        
        if usePost {
            let dto = RecipeFormDTO(recipeForm: recipeForm)
            let result = await recipeService.postRecipe(dto)
            
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                serviceAlert.presentAlert(error)
            }
        } else {
            let dto = RecipeFormDTO(recipeForm: recipeForm)
            guard let recipeId = recipeId else { return }
            let result = await recipeService.patchRecipe(formDTO: dto, recipeId: recipeId)
            
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                serviceAlert.presentAlert(error)
            }
        }
    }
    
    func appendMainIngredientButtonTapped() {
        useMainIngredient = true
        mainIngredientViewIsPresnted = true
    }
    
    func appendOptionalIngredientButtonTapped() {
        useMainIngredient = false
        optioanlIngredientViewIsPresnted = true
    }
}
