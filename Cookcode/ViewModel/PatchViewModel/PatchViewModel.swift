//
//  BasePatchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation
import SwiftUI

protocol PatchViewModel: ObservableObject {
    var serviceAlert: ServiceAlert { get set }
    var useTrashButton: Bool { get }
    var deleteAlertIsPresented: Bool { get set }
    
    func trashButtonTapped()
    func mainButtonTapped(dismissAction: DismissAction) async
    func deleteOkButtonTapped(dismissAction: DismissAction) async
}

extension PatchViewModel {
    func trashButtonTapped() {
        deleteAlertIsPresented = true 
    }
}
