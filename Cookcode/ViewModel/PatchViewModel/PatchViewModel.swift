//
//  BasePatchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation

protocol PatchViewModel: ObservableObject {
    func trashButtonTapped()
    func mainButtonTapped() 
}
