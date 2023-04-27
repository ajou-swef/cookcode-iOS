//
//  SlidInfoView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PhotosUI

struct RecipeFormView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel: RecipeFormViewModel = .init()
    @State private var step: StepForm?
    
    var body: some View {
        NavigationStack(path: $navigateViewModel.recipePath) {
            VStack {
                ScrollView {
                    VStack(spacing: 10) {
                        TitleSection()
                        ImageSection()
                        DescriptionSection()

                        MainIngredients()
                        OptionalIngredients()
                        
                        Steps()
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 30)
                }
                
                VStack {
                    Button {
                        viewModel.isShowingPreviewView = true
                    } label: {
                        Text("미리보기")
                            .font(CustomFontFactory.INTER_SECTION_TITLE)
                            .foregroundColor(.white)
                            .roundedRectangle(.GRAY_320_FILLED,
                                              focused: !viewModel.previewButtonIsAvailable)
                    }
                    .disabled(!viewModel.previewButtonIsAvailable)

                }
            }
            .fullScreenCover(isPresented: $viewModel.isShowingPreviewView) {
                RecipePreviewView(viewModel: viewModel)
            }
            .sheet(item: $viewModel.stepFormTrigger) { item in
                StepFormView(viewModel: viewModel, stepIndex: item.index)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        navigateViewModel.dismissRecipeFormView()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("새 레시피")
                        .font(CustomFontFactory.INTER_SECTION_TITLE)
                }
            }
            .onChange(of: viewModel.mainImageItem) { newItem in
                Task {
                    // Retrive selected asset in the form of Data
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        viewModel.mainImageData = data
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func DescriptionSection() -> some View {
        Section {
            VStack(spacing: 5) {
                TextField("설명을 입력해주세요",
                          text: $viewModel.recipeMetadata.description)
                    .font(CustomFontFactory.INTER_REGULAR_14)
                
                CCDivider()
                    .padding(.bottom, 20)
            }
        } header: {
            HStack {
                Text("설명")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
            }
        }
    }
    @ViewBuilder
    private func ImageSection() -> some View {
        Section {
            VStack(spacing: 5) {
                PhotosPicker(selection: $viewModel.mainImageItem) {
                    if let selectedData = viewModel.mainImageData, let uiImage = UIImage(data: selectedData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(maxWidth: 320, maxHeight: 200)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .foregroundColor(.gray_bcbcbc)
                            .frame(maxWidth: 120, minHeight: 100)
                            .padding(.horizontal, 100)
                            .padding(.vertical, 50)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 3)
                                    .foregroundColor(.gray_bcbcbc)
                            }
                    }
                }
                .padding(.bottom, 20)
            }
        } header: {
            HStack {
                Text("대표 이미지")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func TitleSection() -> some View {
        Section {
            VStack(spacing: 5) {
                HStack {
                    TextField("입력해주세요",
                              text: $viewModel.recipeMetadata.title)
                    .font(CustomFontFactory.INTER_TITLE)
                    
                    Spacer()
                }
                
                CCDivider()
                    .padding(.bottom, 20)
            }
        } header: {
            HStack {
                Text("레시피 이름")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                    .frame(alignment: .leading)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func MainIngredients() -> some View {
        Section {
           
        } header: {
            HStack {
                Text("필수재료")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("추가")
                            .font(CustomFontFactory.INTER_REGULAR_14)
                    }
                    .foregroundColor(.primary)
                }

            }
        }
    }
    
    @ViewBuilder
    private func OptionalIngredients() -> some View {
        Section {
            
            CCDivider()
                .padding(.bottom, 20)
        } header: {
            HStack {
                Text("보조재료")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("추가")
                            .font(CustomFontFactory.INTER_REGULAR_14)
                    }
                    .foregroundColor(.primary)
                }

            }
        }
    }
    
    @ViewBuilder
    private func Steps() -> some View {
        Section {
            VStack(spacing: 10) {
                ForEach(viewModel.stepForms.indices, id: \.self) { i in
                    Button {
                        viewModel.showStepFormView(i)
                    } label: {
                        HStack {
                            Text("\(i+1)단계")
                                .font(CustomFontFactory.INTER_SECTION_TITLE)
                                .padding(.trailing, 15)
                                .foregroundColor(.mainColor)
                            
                            Spacer()
                        }
                    }
                }
            }
        } header: {
            HStack {
                Text("스텝")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
                
                Button {
                    viewModel.addFirstStepButtonTapped()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("추가")
                            .font(CustomFontFactory.INTER_REGULAR_14)
                    }
                    .foregroundColor(.primary)
                }

            }
        }
    }
}

struct RecipeFormView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFormView()
    }
}
