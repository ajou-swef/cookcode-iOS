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
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    SearchTypePicker(selection: $viewModel.searchType, activeTint: .mainColor, inActiveTint: .gray_bcbcbc, dynamic: false)
                        .frame(width: 100)
                    
                    Spacer()
                }
                .zIndex(1)
                
                LazyVGrid(columns: viewModel.columns, spacing: 20 + viewModel.offsetY) {
                    ForEach(viewModel.recipeCellSearch.recipeCells.indices, id: \.self) { i in
                        let recipeCell = viewModel.recipeCellSearch.recipeCells[i]
                        
                        Button {
                            navigateViewModel.navigateWithHome(recipeCell)
                        } label: {
                            RecipeCellView(recipeCell: recipeCell, offsetY: viewModel.offsetY)
                                .frame(height: viewModel.recipeCellHeight)
                        }
                    }
                }
                .zIndex(0)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, viewModel.offsetY)
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
