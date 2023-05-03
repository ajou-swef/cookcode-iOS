//
//  SelectIngredientView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/03.
//

import SwiftUI

struct SelectIngredientView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var text: String = "123"
    
    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(0..<INGREDIENTS.count) { i in
//                    let ingredient = INGREDIENTS[i+1]
//                    if let ingredient = ingredient {
//                        IngredientCellView(cell: ingredient)
//                    }
//                }
//            }
//        }
    }
}

struct SelectIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        SelectIngredientView()
    }
}
