//
//  UpdateCellViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/22.
//

import SwiftUI

final class UpdateCellViewModel: ObservableObject {
    @Published private var _updateCellDict: [CellType: CellUpdateInfo] = [:]
    @Published var scheme: ColorScheme = .light
    
    var updateCellDict: [CellType: CellUpdateInfo] {
        get { _updateCellDict }
        set { _updateCellDict = newValue }
    }

}
