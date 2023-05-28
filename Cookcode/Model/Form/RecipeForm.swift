//
//  RecipeMetadata.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import Foundation
import _PhotosUI_SwiftUI

struct RecipeForm {
    var title: String = ""
    var description: String = ""
    var ingredients: [Int] = []
    var optionalIngredients: [Int] = []
    var photosPickerItem: PhotosPickerItem?
    private(set) var _thumbnail: String = ""
    private(set) var deletedThumbnails: [String] = []
    
    var steps: [ContentWrappedStepForm] = []
    
    var thumbnail: String {
        get { _thumbnail }
        set { _thumbnail = newValue }
    }
    
    var anyStepLacksOfInformation: Bool {
        steps.contains { $0.lacksOfInformation }
    }
    
    var anyRequiredInformationIsEmpty: Bool {
        title.isEmpty || description.isEmpty || _thumbnail.isEmpty || steps.isEmpty
    }
    
    mutating func updateThumbnail(url: String) {
        if !_thumbnail.isEmpty {
            deletedThumbnails.append(_thumbnail)
        }
        
        _thumbnail = url
    }
    
    mutating func appendStep(_ step: ContentWrappedStepForm) {
        steps.append(step)
    }
    
    mutating func removeStepAt(_ at: Int) {
        steps.remove(at: at)
    }
    
    mutating func stepChangesContent(_ at: Int) {
        steps[at].changeContent()
    }
    
    mutating func stepAppendContentURL(_ at: Int, urls: [String]) {
        steps[at].resetContentURLto(urls)
    }
}

extension RecipeForm {
    init(recipeDetailDTO: RecipeDetailDTO) {
        title = recipeDetailDTO.title
        description = recipeDetailDTO.description
        ingredients = recipeDetailDTO.ingredients.map { $0.ingredientID }
        optionalIngredients = recipeDetailDTO.optionalIngredients.map { $0.ingredientID }
        thumbnail = recipeDetailDTO.thumbnail
        steps = recipeDetailDTO.steps.map { ContentWrappedStepForm(stepDetailDTO: $0) }
    }
}
