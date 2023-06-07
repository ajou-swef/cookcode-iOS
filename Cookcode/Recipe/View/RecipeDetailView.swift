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
    @EnvironmentObject var updateCellVM: UpdateCellViewModel
    
    init(recipeId: Int) {
        self._viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipeId: recipeId))
    }
    
    var body: some View {
        Group {
            ProgressView()
                .presentIf(viewModel.isLoading)
            
            
            RecipeView(viewModel: viewModel)
                .confirmationDialog("수정", isPresented: $viewModel.showDialog, actions: {
                    dialogButtons()
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                      recipeToolbar()
                    }
                }
                .presentIf(!viewModel.isLoading)
        }
        .navigationTitle("레시피")
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            Button {
                Task { navigateVM.clear() }
            } label: {
                Text("확인")
            }

        }
    }
    
    @ViewBuilder
    private func dialogButtons() -> some View {
        Group {
            Button {
                navigateVM.navigateToOuter(OuterIdPath(path: .recipe, id: viewModel.recipeDetail.recipeID))
            } label: {
                Text("수정")
            }
            
            Button {
                Task {
                    updateCellVM.updateCellDict[.recipe] = CellUpdateInfo(updateType: .delete, cellId: viewModel.recipeDetail.recipeID ?? -1 )
                    await viewModel.deleteButtonTapepd(dismiss: navigateVM.clear)
                }
            } label: {
                Text("삭제")
                    .foregroundColor(.red)
            }
        }
    }
    
    @ViewBuilder
    private func recipeToolbar() -> some View {
        HStack {
            presentCommentComponentButton()

            
            Button {
                viewModel.showDialog = true
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
            }
            .presentIf(viewModel.myRecipe)
            
            LikeButton(viewModel: viewModel, like: viewModel.recipeDetail, color: .black,
                       showCounts: false, width: 20)
                .presentIf(!viewModel.myRecipe)
        }
    }
    
    @ViewBuilder
    private func presentCommentComponentButton() -> some View {
        Button {
            viewModel.commentsComponentIsPresented = true
        } label: {
            Image(systemName: "ellipsis.bubble.fill")
        }
        .sheet(isPresented: $viewModel.commentsComponentIsPresented) {
            CommentList(viewModel:
                            CookieCommentViewModel(conentsId: viewModel.recipeId, commentService: viewModel.recipeService))
        }
    }
}

//struct RecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView()
//    }
//}
