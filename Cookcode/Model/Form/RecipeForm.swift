//
//  RecipeMetadata.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import Foundation
import PhotosUI

struct RecipeForm: Codable {
    var title: String = ""
    var description: String = ""
    
    var ingredients: [Int] = []
    var optionalIngredients: [Int] = []
    
    private(set) var _thumbnail: String = ""
    private(set) var deletedThumbnails: [String] = []
    
    
    var thumbnail: String {
        get { _thumbnail }
        set(newValue) { _thumbnail = newValue }
    }
    
    var steps: [ContentWrappedStepForm] = []
    
    var anyStepLacksOfInformation: Bool {
        steps.contains { $0.lacksOfInformation }
    }
    
    var anyRequiredInformationIsEmpty: Bool {
        title.isEmpty || description.isEmpty || _thumbnail.isEmpty
    }
    
    mutating func updateThumbnail(url: [String]) {
        if !_thumbnail.isEmpty {
            deletedThumbnails.append(_thumbnail)
        }
        
        if url.count >= 1 {
            _thumbnail = url[0]
        }
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
