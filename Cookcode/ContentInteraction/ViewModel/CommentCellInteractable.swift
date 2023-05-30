//
//  CommentSelectable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/30.
//

import Foundation

protocol CommentCellInteractable: ObservableObject {
    var selectedComment: Comment? { get set }
    func commentButtonTapped(_ comment: Comment) 
}

