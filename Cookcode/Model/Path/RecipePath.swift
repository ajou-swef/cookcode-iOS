//
//  RecipePath.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import Foundation

struct RecipePathWithIndex: Hashable, Identifiable {
    let id: String = UUID().uuidString
    let path: RecipePath
    let index: Int 
}

enum RecipePath: String, CaseIterable {
    case step = "step"
    case preview = "preview"
}
