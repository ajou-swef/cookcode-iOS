//
//  CookieProgress.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/08.
//

import SwiftUI

final class CookieProgress: ObservableObject {
    
    @Published var progress: Progress = .init()
    @Published var uploadingState: UploadState = .none
    @Published var reuploadAlertIsPresented: Bool = false
    @Published var cookieForm: CookieForm = .init()
    
    enum UploadState {
        case uploading
        case none
        case fail
    }
    
    let cookieService: CookieServiceProtocol
    
    var isUploading: Bool {
        uploadingState == .uploading
    }
    
    init(cookieService: CookieServiceProtocol) {
        self.cookieService = cookieService
    }
    
    @MainActor
    func postCookie(cookieForm: CookieForm) {
        Task {
            self.cookieForm = cookieForm
            uploadingState = .uploading
            
            let result = await cookieService.postCookie(cookie: cookieForm, closure: {
                self.progress = $0
            })
            
            switch result {
            case .success(_):
                uploadingState = .none
                print("업로드 성공")
            case .failure(_):
                uploadingState = .fail
                print("업로드 실패")
            }
        }
    }
    
    @MainActor
    func repostCookie() {
        Task {
            uploadingState = .uploading
            
            let result = await cookieService.postCookie(cookie: cookieForm, closure: {
                self.progress = $0
            })
            
            switch result {
            case .success(_):
                uploadingState = .none
                print("업로드 성공")
            case .failure(_):
                uploadingState = .fail
                print("업로드 실패")
            }
        }
    }
}
