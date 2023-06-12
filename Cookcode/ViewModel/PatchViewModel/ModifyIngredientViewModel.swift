//
//  IngredientPatchViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import Foundation
import SwiftUI

class ModifyIngredientViewModel: PatchIngredientViewModel {
    
    internal let useTrashButton: Bool = true
    @Published var ingredientForm: IngredientForm
    @Published var ingredientCell: IngredientCell
    @Published var serviceAlert: ViewAlert = .init()
    @Published var deleteAlertIsPresented: Bool = false
    
    internal let refridgeratorService: RefrigeratorServiceProtocol
    private let fridgeIngredId: Int
    
    init(ingredientDetail: IngredientDetail, refridgeratorService: RefrigeratorServiceProtocol) {
        ingredientCell = IngredientCell(detail: ingredientDetail)
        ingredientForm = IngredientForm(detail: ingredientDetail)
        self.refridgeratorService = refridgeratorService
        fridgeIngredId = ingredientDetail.fridgeIngredId
    }
    
    @MainActor
    func deleteOkButtonTapped(dismissAction: DismissAction) async {
        let result = await refridgeratorService.deleteIngredient(fridgeIngredId: fridgeIngredId)
        switch result {
        case .success(_):
            dismissAction()
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
    
    @MainActor
    func mainButtonTapped(dismissAction: DismissAction) async {
        let dto = IngredientFormDTO(form: ingredientForm)
        let result = await refridgeratorService.patchIngredient(dto: dto, fridgeIngredId: fridgeIngredId)

        switch result {
        case .success(_):
            print("??")
            dismissAction()
        case .failure(let failure):
            serviceAlert.presentServiceError(failure)
        }
    }
}
