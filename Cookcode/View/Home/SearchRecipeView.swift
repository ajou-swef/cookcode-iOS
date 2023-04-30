//
//  SearchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/30.
//

import SwiftUI
import Kingfisher

struct SearchRecipeView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel: SearchRecipeViewModel = SearchRecipeViewModel(recipeService: RecipeSuccessService())
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
    ]
    
    let recipeCellHeight: CGFloat = 200
    let offsetY: CGFloat = 20
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20 + offsetY) {
                ForEach(viewModel.recipeCellSearch.recipeCells.indices, id: \.self) { i in
                    let recipeCell = viewModel.recipeCellSearch.recipeCells[i]
                    
                    Button {
                        navigateViewModel.navigateWithHome(recipeCell)
                    } label: {
                        RecipeCellView(recipeCell: recipeCell, offsetY: offsetY)
                            .frame(height: recipeCellHeight)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, offsetY)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("레시피 검색", text: $viewModel.text)
                    .frame(maxWidth: .infinity)
                    .onSubmit {
                        viewModel.searchRecipe()
                    }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecipeView()
    }
}
