//
//  SelectIngredientView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import SwiftUI

struct SelectIngredientView: View {
    
    enum Field {
        case search
    }
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
    ]
    
    @StateObject private var viewModel: SelectIngredientViewModel = .init()
    @FocusState private var focused: Field?
    @Binding var selectedIngredientCells: [Int]
    
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
                                            .hidden(viewModel.ingredientCellIsNotContained(id))
                                    }
                            }
                            .hidden(!viewModel.searchText.isEmpty && !ingredient.title.contains(viewModel.searchText))
                        }
                        
                    }
                }
            }
        }
        .onChange(of: viewModel.selectedIngredientIDs) { newValue in
            selectedIngredientCells = newValue
        }
    }
}

struct SelectIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        SelectIngredientView(selectedIngredientCells: .constant([]))
    }
}
