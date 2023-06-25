//
//  LikeButtonInteractable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/05.
//

import Foundation

protocol likeButtonInteractable: ObservableObject {
    func likeButtonTapped(_ uuid: String) async
}
