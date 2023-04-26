//
//  ContentWrappedStep.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import SwiftUI
import PhotosUI

struct ContentWrappedStepForm: Identifiable {
    let id: String = UUID().uuidString
    var stepForm: StepForm = .init()
    var photoPickerItems: [PhotosPickerItem] = .init()
    
    private var _contentType: ContentType = .image {
        willSet {
            photoPickerItems.removeAll()
            imageDatas.removeAll()
            videoURLs.removeAll()
        }
    }
    
    var imageDatas: [Data] = .init()
    var videoURLs: [VideoURL] = .init()
    
    var contentType: ContentType {
        get {
            return _contentType
        }
        
        set(value) {
           _contentType = value
        }
    }
    
    var phpFilter: PHPickerFilter {
        contentType.phpFilter
    }
    
    var maxSelection: Int {
        contentType.maxSelection
    }
    
    var useImageType: Bool {
        contentType == .image
    }
    
    var useVideoType: Bool {
        contentType == .video
    }
    
    var containsAnyImage: Bool {
        !imageDatas.isEmpty
    }
    
    var containsAnyVideoURL: Bool {
        !videoURLs.isEmpty
    }
    
    var fillAllRequiredInformation: Bool {
        !stepForm.isEmptyTitle && !stepForm.isEmptyDescription &&
        (!photoPickerItems.isEmpty || !imageDatas.isEmpty)
    }
    
    mutating func changeContent() {
        if contentType == .image {
            contentType = .video
        } else {
            contentType = .image
        }
    }
    
    mutating func load() async {
        imageDatas.removeAll()
        videoURLs.removeAll()
        
        switch contentType {
        case .video:
            for item in photoPickerItems {
                if let video = try? await item.loadTransferable(type: VideoURL.self) {
                    videoURLs.append(video)
                }
            }
        case .image:
            for item in photoPickerItems {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    imageDatas.append(data)
                }
            }
        }
    }
}
