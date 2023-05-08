//
//  BasePatchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import SwiftUI

struct BasePatchView<ViewModel, Content>: View where ViewModel: PatchViewModel, Content: View {
    
    @ObservedObject var viewModel: ViewModel
    let content: () -> Content
    
    init (viewModel: ViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        VStack {
            content() 
            
            Spacer()
            
            HStack {
                Button {
                    viewModel.trashButtonTapped()
                } label: {
                    Image(systemName: "trash.square")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray_bcbcbc)
                }
                
                Button {
                    viewModel.mainButtonTapped()
                } label: {
                    Text("저장")
                        .roundedRectangle(.ORANGE_280_FILLED)
                        .foregroundColor(.white)
                        .font(CustomFontFactory.INTER_BOLD_16)
                }

            }
        }
    }
}

//struct BasePatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        BasePatchView(viewModel: IngredientPatchViewModel(ingredientId: 1)) {
//            Text("BasePatchView")
//        }
//    }
//}
