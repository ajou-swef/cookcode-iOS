//
//  RecipePreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/11.
//

import SwiftUI

struct RecipePreviewView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigateVM: NavigateViewModel
    @ObservedObject var viewModel: RecipeFormViewModel
    
    var body: some View {
        ZStack {
           Color.gray808080
               .ignoresSafeArea(.all)
               .overlay(alignment: .top) {
                   TopButton()
               }
            
            RecipeView(recipeFormViewModel: viewModel)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 40)
                .padding(.horizontal, 20)
                .overlay(alignment: .bottom) {
                    Button {
                        viewModel.presentStepFormView()
                    } label: {
                        Text("수정")
                            .font(CustomFontFactory.INTER_SEMIBOLD_14)
                            .foregroundColor(.white)
                            .roundedRectangle(.ORANGE_280_FILLED, focused: true)
                            .padding(.bottom, 10)
                    }
                }
            
        }
        .sheet(item: $viewModel.stepFormTrigger) { item  in
            StepFormView(viewModel: viewModel, stepIndex: item.index)
        }
        .navigationBarBackButtonHidden()
        .statusBarHidden()
    }
    
    @ViewBuilder
       private func TopButton() -> some View {
           HStack {
               Button {
                   dismiss()
               } label: {
                   Image(systemName: "xmark.circle.fill")
                       .resizable()
                       .foregroundColor(.mainColor)
                       .frame(maxWidth: 40, maxHeight: 40)
                       .background(
                           Circle()
                               .fill(Color.white)
                               .frame(maxWidth: 30, maxHeight: 30)
                       )
               }
   
               Spacer()
   
               Button {
                   Task {
                       await viewModel.uploadButtonTapped()
                       navigateVM.dismissOuter()
                   }
               } label: {
                   Image(systemName: "square.and.arrow.up.circle.fill")
                       .resizable()
                       .foregroundColor(.mainColor)
                       .frame(maxWidth: 40, maxHeight: 40)
                       .background(
                           Circle()
                               .fill(Color.white)
                               .frame(maxWidth: 30, maxHeight: 30)
                       )
               }
   
           }
           .padding(.top, 20)
           .ignoresSafeArea()
           .padding(.horizontal, 20)
       }
}

//struct RecipePreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipePreviewView()
//    }
//}
