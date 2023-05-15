//
//  IngredientPatchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import SwiftUI

struct IngredientPatchComponent<ViewModel>: View where ViewModel: PatchIngredientViewModel{
    
    enum Field {
        case quantity
        
    }
    
    @ObservedObject private var viewModel: ViewModel
    @FocusState private var fouces: Field?
    
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
                
                DatePicker(selection: $viewModel.ingredientForm.expiredAt, displayedComponents: .date) {
                    Text("소비기한")
                }
            
                CCDivider()
                
                HStack {
                    Text("양")
                        .foregroundColor(.gray808080)
                        .font(CustomFontFactory.INTER_SEMIBOLD_20)
                    
                    Spacer()
                    
                    TextField("입력해주세요.", text: $viewModel.ingredientForm.quantity)
                        .keyboardType(.numberPad)
                        .frame(alignment: .trailing)
                        .focused($fouces, equals: .quantity)
                }
                
                Spacer()
                
                PatchComponent(viewModel: viewModel)
            }
            .background {
                Color.white
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
            .navigationTitle("식재료 수정")
            .ignoresSafeArea(.keyboard)
            .onTapGesture {
                print("on Tap gesture")
                fouces = nil
            }
    }
}

//struct IngredientPatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientPatchView(ingredientDetail: )
//    }
//}
