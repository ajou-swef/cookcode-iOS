//
//  TempRecipeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

struct RecipeSearchView: View {
    
    @StateObject private var viewModel = RecipeSearchViewModel(recipeService: RecipeService(), query: "")
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(recipeService: RecipeServiceProtocol = RecipeService(), query: String) {
        self._viewModel = StateObject(wrappedValue: RecipeSearchViewModel(recipeService: recipeService,
                                                                          query: query))
    }
    
    var body: some View {
        RefreshableRecipeFetchView(viewModel: viewModel)
    }
}

struct TempRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView(query: "recipe")
    }
}
