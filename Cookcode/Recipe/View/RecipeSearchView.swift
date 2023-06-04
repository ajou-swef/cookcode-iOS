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
        RefreshComponent(viewModel: viewModel) {
            PagenableComponent(viewModel: viewModel) {
                ForEach(viewModel.contents) { recipeCell in
                   Button {
                       let homeIdPath = HomeIdPath(path: .recipe, id: recipeCell.recipeId)
                       navigateViewModel.navigateWithHome(homeIdPath)
                   } label: {
                       CellView(cell: recipeCell)
                           .foregroundColor(.black)
                           .zIndex(0)
                   }
                   .id(recipeCell.id)
               }
            }
            .padding(.horizontal)
        }
    }
}

struct TempRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView(query: "recipe")
    }
}