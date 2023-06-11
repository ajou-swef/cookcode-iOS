//
//  RecipeViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import Foundation

class RecipeViewModel: ObservableObject {
    
    let recipeService: RecipeServiceProtocol
    
    @Published var recipeDetail: RecipeDetail = .init(dto: .mock())
    @Published var serviceAlert: ServiceAlert = .init()
    @Published var tabSelection: String = ""
    
    init (recipeService: RecipeServiceProtocol, contentService: ContentServiceProtocol, recipeID: Int?) {
        self.recipeService = recipeService
    }
//    func stepID(at :Int) -> String {
//        String(recipeDetail?.steps[at].seq ?? 1)
//    }
}
