//
//  UserAuthInteractable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/12.
//

import SwiftUI

protocol UserAuthInteractable: ObservableObject {
    func userAuthOkButtonTapped(_ userAuth: UserAuth) async
    func userAuthCancelButtonTapped(_ userAuth: UserAuth) async
}
