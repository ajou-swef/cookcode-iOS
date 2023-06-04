//
//  RecipePagenableView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI

struct RecipePagenableView: View {
    
    @StateObject private var viewModel: RecipePagenableViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self._viewModel = StateObject(wrappedValue: RecipePagenableViewModel(recipeService: recipeService))
    }
    
    var body: some View {
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
    }
}

struct RecipePagenableView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePagenableView(recipeService: RecipeSuccessService())
    }
}
