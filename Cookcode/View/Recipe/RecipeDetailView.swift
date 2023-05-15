//
//  RecipeDetailView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/15.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @StateObject private var viewModel: RecipeDetailViewModel
    @EnvironmentObject var navigateVM: NavigateViewModel
    
    init(recipeCell: RecipeCell) {
        self._viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipeCell: recipeCell))
    }
    
    var body: some View {
        RecipeView(viewModel: viewModel)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        navigateVM.navigateToOuter(OuterIdPath(path: .recipe, id: viewModel.recipeDetail.recipeID))
                    } label: {
                        Text("수정")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("레시피")
                }
            }
    }
}

//struct RecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView()
//    }
//}
