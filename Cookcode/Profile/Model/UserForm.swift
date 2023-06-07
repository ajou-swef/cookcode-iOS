//
//  UserForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/07.
//

import SwiftUI
import PhotosUI

struct ProfileForm: Mock {
    static func mock() -> ProfileForm {
        ProfileForm(data: nil, photosPickerItem: nil, thumbnail: nil)
    }
    
    var data: Data?
    var photosPickerItem: PhotosPickerItem?
    var thumbnail: String?
}

extension ProfileForm {
    init (detail: UserDetail) {
        thumbnail = detail.thumbnail
        data = nil
        photosPickerItem = nil 
    }
}
