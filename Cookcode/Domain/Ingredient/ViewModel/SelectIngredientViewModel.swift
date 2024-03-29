//
//  SelectIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/04.
//

import Foundation

protocol SelectIngredientViewModel: ObservableObject {
    var searchText: String { get set }
    func ingredientCellTapped(_ ingredientID: Int)
    func isNotSelected(_ ingredientID: Int) -> Bool
}
