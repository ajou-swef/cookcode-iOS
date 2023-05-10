//
//  StepFormDTO.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Foundation

struct StepFormDTO: Encodable {
    let seq: Int
    let title, description: String
    let videos, photos, deletedVideos, deletedPhotos: [String]
    
    init(form: ContentWrappedStepForm, seq: Int) {
        title = form.title
        description = form.description
        videos = form.videoURLs
        photos = form.imageURLs
        deletedVideos = form.deletedVideos
        deletedPhotos = form.deletedPhotos
        self.seq = seq
    }
}
