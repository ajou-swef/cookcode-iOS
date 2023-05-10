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
    func trashButtonTapped() async
    func mainButtonTapped(dismissAction: DismissAction) async
}
