//
//  TempRecipeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

struct TempRecipeView: View {
    
    @StateObject private var viewModel = RecipeSearchViewModel(recipeService: RecipeService(), query: "")
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(recipeService: RecipeServiceProtocol = RecipeService(), query: String) {
        self._viewModel = StateObject(wrappedValue: RecipeSearchViewModel(recipeService: recipeService,
                                                                          query: query))
    }
    
    var body: some View {
        RefreshComponent(viewModel: viewModel) {
            PagenableComponent(viewModel: viewModel) {
                ForEach(viewModel.recipeCells) {  cell in
                   Button {
                       navigateViewModel.navigateWithHome(cell)
                   } label: {
                       CellView(cell: cell)
                           .foregroundColor(.black)
                           .zIndex(0)
                   }
                   .id(cell.id)
               }
            }
        }
    }
}

struct TempRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        TempRecipeView(query: "recipe")
    }
}
