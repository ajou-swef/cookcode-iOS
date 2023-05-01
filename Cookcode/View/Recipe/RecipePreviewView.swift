//
//  RecipePreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/24.
//

import SwiftUI
import ObservedOptionalObject

struct RecipePreviewView: View {
    
    @ObservedOptionalObject var recipeFormViewModel: RecipeFormViewModel?
    @StateObject var recipeViewModel: RecipeViewModel = .init()
    @Environment(\.dismiss) var dismiss
    
    init(recipeFormViewModel: RecipeFormViewModel) {
        self._recipeFormViewModel = ObservedOptionalObject(wrappedValue: recipeFormViewModel)
    }
    
    init(recipeCell: RecipeCell) {
        self._recipeViewModel = StateObject(wrappedValue: RecipeViewModel(recipeService: RecipeSuccessService(), contentService: ContentSuccessService(), recipeID: recipeCell.recipeID))
    }
    
    var isPreview: Bool {
        recipeFormViewModel != nil
    }
    
    var selection: Binding<String>? {
        if isPreview {
            return $recipeFormViewModel.previewTabSelection
        }
        
        return $recipeViewModel.tabSelection
    }
    
    var title: String {
        if let viewModel = recipeFormViewModel {
            return viewModel.recipeMetadata.title
        } else {
            return "디테일 제목"
        }
    }
    
    var description: String {
        if let viewModel = recipeFormViewModel {
            return viewModel.recipeMetadata.description
        } else {
            return "디테일 설명"
        }
    }
    
    var imageURL: String {
        guard let viewModel = recipeFormViewModel else {
            return "https://picsum.photos/200"
        }
        return "https://picsum.photos/200"
    }
    
    var indicies: Range<Int> {
        guard let viewModel = recipeFormViewModel else {
            return recipeViewModel.recipeDetail?.steps.indices ?? 0..<0
        }
        return viewModel.stepForms.indices
    }
    
    
    var body: some View {
        ZStack {
            if isPreview {
                Color.gray808080
                    .ignoresSafeArea(.all)
                    .overlay(alignment: .top) {
                        TopButton()
                    }
            }
        
            TabView(selection: selection) {
                GeometryReader { proxy in
                    RecipeEntranceView(title: title, description: description, imageURL: imageURL, cgSize: proxy.size)
                }
                .tag("main")
                
                ForEach(indicies, id: \.self) { i in
                    StepPreviewView(stepSequence: i+1, viewModel: recipeFormViewModel, step: recipeViewModel.recipeDetail?.steps[i])
                        .tag(stepID(at: i))
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
        .navigationBarBackButtonHidden(isPreview)
        .statusBarHidden()
    }
    
    func stepID(at: Int) -> String {
        guard let viewModel = recipeFormViewModel else {
            return recipeViewModel.stepID(at: at)
        }
        return viewModel.stepFormID(at: at)
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
//        RecipePreviewView(recipeFormViewModel: RecipeFormViewModel())
//    }
//}
