//
//  ContentWrappedStep.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import SwiftUI
import PhotosUI

struct ContentWrappedStepForm: Equatable { 
    var stepForm: StepForm = .init()
    var photoPickerItems: [PhotosPickerItem] = .init()
    var imageDatas: [Data] = .init()
}
