//
//  MyRecipeView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/02.
//

import SwiftUI

struct MyRecipeView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    let mocks = RecipeCell.mocks(10)
    
    var body: some View {
        List {
            ForEach(mocks) { mock in
                MyRecipeCellView(recipeCell: mock)
                    .onTapGesture {
                        navigateViewModel.navigateWithProfile(RecipeCellDto.MOCK_DATA)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            
                        } label: {
                            Text("삭제")
                        }
                        .tint(.red)
                        
                        Button {
                            navigateViewModel.navigateToOuter(.recipe)
                            navigateViewModel.profilePath = .init()
                        } label: {
                            Text("수정")
                        }
                        .tint(.blue)
                    }
            }
        }
        .navigationTitle("나의 레시피")
    }
}

struct MyRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeView()
    }
}
