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
            .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
                Button {
                    Task { navigateVM.clear() }
                } label: {
                    Text("확인")
                }

            }
            .confirmationDialog("수정", isPresented: $viewModel.showDialog, actions: {
                Button {
                    navigateVM.navigateToOuter(OuterIdPath(path: .recipe, id: viewModel.recipeDetail.recipeID))
                } label: {
                    Text("수정")
                }
                
                Button {
                    Task { await viewModel.deleteButtonTapepd(dismiss: navigateVM.clear) }
                } label: {
                    Text("삭제")
                        .foregroundColor(.red)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showDialog = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .hidden(!viewModel.myRecipe)
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
