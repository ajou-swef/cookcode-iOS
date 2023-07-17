//
//  RecipePagenableView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/02.
//

import SwiftUI
import cookcode_service

struct RecipeUserView: View {
    
    @StateObject private var viewModel: RecipeUserViewModel
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    
    init(recipeService: RecipeServiceProtocol = RecipeService(), userId: Int) {
        self._viewModel = StateObject(wrappedValue: RecipeUserViewModel(recipeService: recipeService, userId: userId))
    }
    
    var body: some View {
        PagenableComponent(viewModel: viewModel) {
            ForEach(viewModel.contents) { recipeCell in
               Button {
                   let homeIdPath = HomeIdPath(path: .recipe, id: recipeCell.recipeId)
                   navigateViewModel.navigateWithHome(homeIdPath)
               } label: {
                   RecipeCellView(cell: recipeCell)
                       .foregroundColor(.black)
                       .zIndex(0)
               }
               .id(recipeCell.id)
               .padding(.bottom, 15)
           }
        }
    }
}

struct RecipePagenableView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeUserView(recipeService: RecipeServiceSuccessStub(), userId: 1)
    }
}
