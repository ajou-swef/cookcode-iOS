//
//  ErrorAlert.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import SwiftUI

struct ServiceAlert {
    static let CANCEL_BUTTON = Button("확인", role: .cancel) { }
    
    var isPresented: Bool = false
    private(set) var title: String = ""
    
    mutating func setTitle(_ title: String) {
        self.title = title
    }
    
    mutating func presentAlert(_ error: ServiceError) {
        isPresented = true
        title = error.message
    }
}
