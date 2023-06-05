//
//  PresentCommentViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import SwiftUI

protocol PresentCommentSheet: ObservableObject {
    var commentSheetIsPresent: Bool { get set }
    var commentService: CommentServiceProtocol { get } 
}
