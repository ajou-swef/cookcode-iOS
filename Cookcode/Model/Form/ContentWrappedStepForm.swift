//
//  ContentWrappedStep.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import SwiftUI
import PhotosUI

struct ContentWrappedStepForm: Identifiable, Codable {
    var id: String = UUID().uuidString
    
    var description: String = ""
    
    private(set) var deletedVideos: [String] = []
    private(set) var deletedPhotos: [String] = []
    private var _contentType: ContentType = .image
    var imageURLs: [String] = [] 
    private(set) var videoURLs: [String] = []
    
    var contentType: ContentType {
        get {
            return _contentType
        }
        
        set(value) {
           _contentType = value
        }
    }
    
    var lacksOfInformation: Bool {
        description.isEmpty || !containsAnyContent
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
    
    var containsAnyContent: Bool {
        containsAnyImage || containsAnyVideoURL
    }
    
    var containsAnyImage: Bool {
        !imageURLs.isEmpty
    }
    
    var containsAnyVideoURL: Bool {
        !videoURLs.isEmpty
    }
    
    var containsAllRequiredInformation: Bool {
        !description.isEmpty &&
        containsAnyContent
    }
    
    mutating func resetContentURLto(_ values: [String]) {
        imageURLs.removeAll()
        videoURLs.removeAll()
        
        switch contentType {
        case .video:
            videoURLs.append(contentsOf: values)
        case .image:
            imageURLs.append(contentsOf: values)
        }
    }
    
    mutating func changeContent() {
        if contentType == .image {
            contentType = .video
            deletedPhotos.append(contentsOf: imageURLs)
            imageURLs.removeAll()
        } else {
            contentType = .image
            deletedVideos.append(contentsOf: videoURLs)
            videoURLs.removeAll()
        }
    }
}

extension ContentWrappedStepForm {
    init(stepDetailDTO: StepDTO) {
        description = stepDetailDTO.description
        imageURLs = stepDetailDTO.photos.map { $0.photoURL }
        videoURLs = stepDetailDTO.videos.map { $0.videoURL }
    }
}
