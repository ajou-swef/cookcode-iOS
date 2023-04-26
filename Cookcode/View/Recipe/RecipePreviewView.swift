//
//  RecipePreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI

struct RecipePreviewView: View {
    
    @ObservedObject var viewModel: RecipeFormViewModel
    
    var body: some View {
        ZStack {
            Color.gray808080
                .ignoresSafeArea(.all)
                .overlay(alignment: .top) {
                   TopButton()
                }
            
            TabView {
                GeometryReader { proxy in
                    RecipeEntranceView(recipeForm: viewModel.recipeMetadata, imageData: viewModel.mainImageData, cgSize: proxy.size)
                }
                
                ForEach(viewModel.stepForms.indices, id: \.self) { i in
                    StepPreviewView(contentWrappedStepForm: viewModel.stepForms[i],
                                    stepSequence: i+1, viewModel: viewModel)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity)
            .background {
                Color.white
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(.horizontal, 10)
            .padding(.top, 30)

        }
        .statusBarHidden()
    }
    
    @ViewBuilder
    private func TopButton() -> some View {
        HStack {
            Button {
                viewModel.isShowingPreviewView = false
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

struct RecipePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePreviewView(viewModel: RecipeFormViewModel(true))
    }
}
