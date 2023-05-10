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
    @Published var serviceAlert: ServiceAlert = .init()
    
    internal let refridgeratorService: RefrigeratorServiceProtocol
    private let fridgeIngredId: Int
    
    init(ingredientDetail: IngredientDetail, refridgeratorService: RefrigeratorServiceProtocol) {
        ingredientCell = IngredientCell(detail: ingredientDetail)
        ingredientForm = IngredientForm(detail: ingredientDetail)
        self.refridgeratorService = refridgeratorService
        fridgeIngredId = ingredientDetail.fridgeIngredId
    }
    
    func trashButtonTapped() {
        print("trashButtonTapped")
    }
    
    func mainButtonTapped(dismissAction: DismissAction) async {
        let dto = IngredientFormDTO(form: ingredientForm)
        let result = await refridgeratorService.patchIngredient(dto: dto, fridgeIngredId: fridgeIngredId)

        switch result {
        case .success(_):
            print("??")
            dismissAction()
        case .failure(let failure):
            serviceAlert.presentAlert(failure)
        }
    }
}
