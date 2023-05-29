//
//  BasePatchView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/05.
//

import SwiftUI

struct PatchComponent<ViewModel>: View where ViewModel: PatchViewModel {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init (viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    fileprivate func trashButton() -> some View {
        Button {
            viewModel.trashButtonTapped()
        } label: {
            Image(systemName: "trash.square")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray_bcbcbc)
        }
        .presentIf(viewModel.useTrashButton)
        .alert("삭제 하시겠습니까?", isPresented: $viewModel.deleteAlertIsPresented) {
            Button("취소", role: .cancel) { }
            Button("확인") {
                Task { await viewModel.deleteOkButtonTapped(dismissAction: dismiss) }
            }
        }
    }
    
    fileprivate func completeButton() -> Button<some View> {
        return Button {
            Task { await viewModel.mainButtonTapped(dismissAction: dismiss) } 
        } label: {
            Text(viewModel.mainButtonText)
                .roundedRectangle(.ORANGE_280_FILLED)
                .foregroundColor(.white)
                .font(CustomFontFactory.INTER_BOLD_16)
        }
    }
    
    var body: some View {
        HStack {
            trashButton()
            completeButton()
        }
        .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
            ServiceAlert.CANCEL_BUTTON
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
