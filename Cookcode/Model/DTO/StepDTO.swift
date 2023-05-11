//
//  StepDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct StepDTO: Codable, Mock, Hashable, Identifiable {
    static func mock() -> StepDTO {
        StepDTO(stepID: 1, seq: 1, title: "title", description: "description", photos: PhotoDTO.mocks(1), videos: VideoDTO.mocks(1))
    }
    
    let id: String = UUID().uuidString
    let stepID, seq: Int
    let title, description: String
    var photos: [PhotoDTO]
    let videos: [VideoDTO]
    
    var containsAllRequiredInformation: Bool {
        !title.isEmpty && !description.isEmpty && !contentURLs.isEmpty
    }
    
    var photosIsEmpty: Bool {
        photos.isEmpty
    }
    
    var contentURLs: [String] {
        if !photosIsEmpty {
            return photos.map { $0.photoURL }
        }
        return videos.map { $0.videoURL }
    }


    enum CodingKeys: String, CodingKey {
        case stepID = "stepId"
        case seq, title, description, photos, videos
    }
    
    init (stepID: Int, seq: Int, title: String, description: String, photos: [PhotoDTO], videos: [VideoDTO]) {
        self.stepID = stepID
        self.seq = seq
        self.title = title
        self.description = description
        self.photos = photos
        self.videos = videos
    }
    
    init (form: ContentWrappedStepForm) {
        self.stepID = 1
        self.seq = 1
        self.title = form.title
        self.description = form.description
        self.photos = []
        
        for i in form.imageURLs.indices {
            photos.append(PhotoDTO(imageURL: form.imageURLs[i], stepPhotoID: i))
        }
        
        self.videos = []
    }
}
