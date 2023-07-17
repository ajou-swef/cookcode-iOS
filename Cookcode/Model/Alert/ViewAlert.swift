//
//  ErrorAlert.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/28.
//

import SwiftUI
import cookcode_service

protocol AlertDelegate: AnyObject {
    func actionButtonTapped() async
}

struct ViewAlert {
    
    static let cancelButton = Button("확인", role: .cancel) { }
    
    var isPresented: Bool = false
    var actionButtonIsPresented: Bool = false
    
    private(set) var title: String = ""
    private(set) var message: String = ""
    private(set) var buttonMessage: String = ""
    
    
    var actionButton: some View {
        Button {
            Task { await delegate?.actionButtonTapped() }
        } label: {
            Text("\(buttonMessage)")
        }
        .presentIf(actionButtonIsPresented) 
    }
    
    weak var delegate: AlertDelegate?
    
    mutating func presentServiceError(_ error: ServiceError) {
        print("\(error)")
        
        isPresented = true
        actionButtonIsPresented = false
        
        title = "\(error.status) 에러"
        message = error.message
    }
    
    mutating func presentActionAlert(title: String, message: String, buttonMessage: String) {
        isPresented = true
        actionButtonIsPresented = true
        self.title = title
        self.message = message
        self.buttonMessage = buttonMessage
    }
    
    mutating func presentAlert(title: String, message: String) async {
        isPresented = true
        actionButtonIsPresented = false
        self.title = title
        self.message = message
        await delegate?.actionButtonTapped()
    }
}
