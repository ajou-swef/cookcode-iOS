//
//  SearchRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation
import SwiftUI

class SearchCellViewModel: SearchTypeSelectable {
    @Published var seachType: SearchType = .recipe
    @Published var text: String = ""
    
    @MainActor
    func searchTypeTapped(_ searchType: SearchType) {
        print("\(seachType) -> \(searchType)")
        seachType = searchType
    }
}
