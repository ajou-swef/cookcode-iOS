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
    var videoURLs: [VideoURL] = .init() {
        willSet(newValue) {
            for value in newValue {
                print("\(value.url.absoluteString)")
            }
        }
    }
    
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
    
    var useImage: Bool {
        contentType == .image
    }
    
    var useVideo: Bool {
        contentType == .video
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
