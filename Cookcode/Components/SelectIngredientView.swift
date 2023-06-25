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
    
    var ingredients: [IngredientType: [IngredientCell]]
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        ingredients = [:]
        
        for type in IngredientType.allCases {
            self.ingredients[type] = []
        }
        
        for ingredientCell in INGREDIENTS_DICTIONARY.values {
            let type = ingredientCell.ingredientType
            ingredients[type]?.append(ingredientCell)
        }
    }
    
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
                ForEach(IngredientType.allCases) { type in
                    ingredientSection(type)
                }
            }
        }
        .padding(.top, 20 )
    }
    
    @ViewBuilder
    private func ingredientSection(_ type: IngredientType) -> some View {
        if let specificIngredients = ingredients[type] {
            Section {
                LazyVGrid(columns: columns) {
                    ForEach(specificIngredients) { ingredient in
                        let id = ingredient.ingredId
                        
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
            } header: {
                Text(type.korean)
                    .font(CustomFontFactory.INTER_BOLD_16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
            }
        }
    }
}

//struct SelectIngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
