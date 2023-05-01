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
    var mainIngredients: [String] = []
    var optionalIngredients: [String] = []
    
    var thumbnail: String = ""
    var deletedThumbnails: [String] = .init()
    
    var thumbnailIsEmpty: Bool {
        thumbnail.isEmpty
    }
    
    var titleIsEmpty: Bool {
        title.isEmpty
    }
    
    mutating func updateThumbnail(url: [String]) {
        if !thumbnailIsEmpty {
            deletedThumbnails.append(thumbnail)
        }
        
        if url.count >= 1 {
            thumbnail = url[0]
        }
    }
}
