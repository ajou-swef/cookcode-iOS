//
//  SearchRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation
import SwiftUI

class SearchRecipeViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var cells: [any Cell] = []
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var searchType: SearchType = .recipe

    var fetchCellService: FetchCellServiceProtocol
    
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    let recipeCellHeight: CGFloat = 200
    
    init (fetchCellService: FetchCellServiceProtocol ) {
        self.fetchCellService = fetchCellService
    }
    
    @MainActor
    func searchRecipe() async {
        let result = await fetchCellService.fetchCell(page: 0, size: 0, sort: "sort", month: 0)
        
        switch result {
        case .success(let success):
            cells.append(contentsOf: success)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
