//
//  SelectIngredientView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import SwiftUI

struct SelectIngredientView<ViewModel>: View where ViewModel: SelectIngredientViewModel {
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
    ]
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                
                TextField("검색", text: $viewModel.searchText)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background {
                Color.gray_bcbcbc
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal, 10)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0..<INGREDIENTS_DICTIONARY.count, id: \.self) { i in
                        let id = i+1
                        let ingredient: IngredientCell? = INGREDIENTS_DICTIONARY[id]
                        
                        if let ingredient = ingredient {
                            Button {
                                viewModel.ingredientCellTapped(id)
                            } label: {
                                IngredientCellView(cell: ingredient)
                                    .overlay(alignment: .topTrailing) {
                                        Circle()
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(.mainColor)
                                            .hidden(viewModel.isNotSelected(id))
                                    }
                            }
                            .hidden(!ingredient.title.contains(viewModel.searchText) && !viewModel.searchText.isEmpty)
                        }
                    }
                }
            }
        }
        .padding(.top, 20 )
    }
}

//struct SelectIngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
