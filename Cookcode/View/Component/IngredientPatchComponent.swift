//
//  IngredientPatchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import SwiftUI

struct IngredientPatchComponent<ViewModel>: View where ViewModel: PatchIngredientViewModel{
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            VStack {
                HStack {
                    Text("종류")
                        .foregroundColor(.gray808080)
                        .font(CustomFontFactory.INTER_SEMIBOLD_20)
                    
                    Spacer()
                    
                    IngredientCellView(cell: viewModel.ingredientCell,
                                       isVertical: false)
                }
            
                CCDivider()
            
                HStack {
                    Text("소비기한")
                        .foregroundColor(.gray808080)
                        .font(CustomFontFactory.INTER_SEMIBOLD_20)
                    
                    
                    DatePicker(selection: $viewModel.ingredientForm.expiredAt,
                               displayedComponents: .date) {

                    }
                    .datePickerStyle(.compact)
                }
            
                CCDivider()
                
                HStack {
                    Text("양")
                        .foregroundColor(.gray808080)
                        .font(CustomFontFactory.INTER_SEMIBOLD_20)
                    
                    Spacer()
                    
                    TextField("입력해주세요.", text: $viewModel.ingredientForm.quantity)
                        .keyboardType(.numberPad)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Text("테스트")
                            }
                        }
                }
                
                Spacer()
                
                PatchComponent(viewModel: viewModel)
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
        .navigationTitle("식재료 수정")
        .ignoresSafeArea(.keyboard)
    }
}

//struct IngredientPatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientPatchView(ingredientDetail: )
//    }
//}
