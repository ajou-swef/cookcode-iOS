//
//  BasePatchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation
import SwiftUI

protocol PatchViewModel: ObservableObject {
    var serviceAlert: ViewAlert { get set }
    var useTrashButton: Bool { get }
    var deleteAlertIsPresented: Bool { get set }
    var mainButtonText: String { get }
    
    func mainButtonTapped(dismissAction: DismissAction) async
    func deleteOkButtonTapped(dismissAction: DismissAction) async
    func trashButtonTapped()
}

extension PatchViewModel {
    var mainButtonText: String {
        "저장하기"
    }
    
    func trashButtonTapped() {
        deleteAlertIsPresented = true 
    }
}
