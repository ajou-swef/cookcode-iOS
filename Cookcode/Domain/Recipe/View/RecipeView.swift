//
//  RecipePreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI
import ObservedOptionalObject

struct RecipeView: View {
    
    @ObservedObject var recipeViewModel: RecipeViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigateVM: NavigateViewModel
    
    init(recipeFormViewModel: RecipeFormViewModel) {
        self.recipeViewModel = recipeFormViewModel
    }
    
    init(viewModel: RecipeViewModel) {
        recipeViewModel = viewModel
    }
    
    var body: some View {
        TabView(selection: $recipeViewModel.tabSelection) {
                GeometryReader { proxy in
                    RecipeEntranceView(recipeDetail: recipeViewModel.recipeDetail, cgSize: proxy.size)
                }
                .tag("main")
                
            ForEach(recipeViewModel.recipeDetail.steps.indices, id: \.self) { i in
                let cell = recipeViewModel.recipeDetail.steps[i]
                StepCellView(cell: cell)
                    .tag(cell.id)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity)
        .background {
            Color.white
        }
    }
}

//struct RecipePreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipePreviewView(recipeFormViewModel: RecipeFormViewModel())
//    }
//}
