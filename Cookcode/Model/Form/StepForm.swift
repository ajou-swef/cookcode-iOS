//
//  StemForm.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import Foundation

struct StepForm: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String = ""
    var description: String = ""
    
    var titleIsEmpty: Bool {
        title.isEmpty
    }
    
    var descriptionIsEmpty: Bool {
        description.isEmpty
    }
}
