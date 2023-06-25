//
//  PatchIngredientViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/10.
//

import Foundation

protocol PatchIngredientViewModel: PatchViewModel {
    var ingredientForm: IngredientForm { get set }
    var ingredientCell: IngredientCell { get set }
    var refridgeratorService: FridgeServiceProtocol { get } 
}
