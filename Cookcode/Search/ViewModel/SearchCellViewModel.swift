//
//  SearchRecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation
import SwiftUI

class SearchCellViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var cells: [any SearchedCell] = []
    
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var searchType: SearchType = .recipe

    private var searchCellService: SearchCellServiceProtocol
    
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    let recipeCellHeight: CGFloat = 200
    
    init (fetchCellService: SearchCellServiceProtocol ) {
        self.searchCellService = fetchCellService
    }
    
    @MainActor
    func searchCell() async {
        let result = await searchCellService.searchCell(page: 0, size: 0, sort: "sort", month: 0)
        
        switch result {
        case .success(let success):
            cells.append(contentsOf: success)
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
