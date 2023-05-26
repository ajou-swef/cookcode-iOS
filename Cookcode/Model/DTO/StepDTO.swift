//
//  StepDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import Foundation

struct StepDTO: Codable, Mock, Hashable, Identifiable {
    static func mock() -> StepDTO {
        StepDTO(stepID: 1, seq: 1, description: "description", photos: PhotoDTO.mocks(1), videos: VideoDTO.mocks(1))
    }
    
    let id: String = UUID().uuidString
    let stepID, seq: Int
    let description: String
    var photos: [PhotoDTO]
    var videos: [VideoDTO]
    
    var containsAllRequiredInformation: Bool {
        !description.isEmpty && !contentURLs.isEmpty
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
        case seq, description, photos, videos
    }
    
    init (stepID: Int, seq: Int, description: String, photos: [PhotoDTO], videos: [VideoDTO]) {
        self.stepID = stepID
        self.seq = seq
        self.description = description
        self.photos = photos
        self.videos = videos
    }
    
    init (form: ContentWrappedStepForm, seq: Int) {
        self.stepID = seq
        self.seq = seq
        self.description = form.description
        self.photos = []
        
        for i in form.imageURLs.indices {
            photos.append(PhotoDTO(imageURL: form.imageURLs[i], stepPhotoID: i))
        }
        
        self.videos = []
        for i in form.videoURLs.indices {
            videos.append(VideoDTO(stepVideoID: i, videoURL: form.videoURLs[i]))
        }
    }
}
