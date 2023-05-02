//
//  RecipeCell.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import Foundation

struct RecipeCell: Cell {
    static func Mock() -> RecipeCell {
        RecipeCell(thumbnail: "https://picsum.photos/200", title: "맛있는 요리", userNmae: "Page")
    }
    
    
    typealias MockType = RecipeCell
    
    var thumbnail: String
    var title: String
    var userNmae: String
}
