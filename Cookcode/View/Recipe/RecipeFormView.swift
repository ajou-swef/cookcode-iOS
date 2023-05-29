//
//  SlidInfoView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct RecipeFormView: View {
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
        GridItem(.adaptive(minimum: 60, maximum: 60)),
    ]
    
    enum Field {
        case title
        case description
    }
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var viewModel: RecipeFormViewModel
    @FocusState private var isFocused: Field?
    
    init(recipeId: Int?) {
        self._viewModel = StateObject(wrappedValue: RecipeFormViewModel(contentService: ContentService(), recipeService: RecipeService(), recipeId: recipeId))
    }
    
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
                    .padding(.bottom, 40)
                }
                
                PresentPreviewButton()
                    .hidden(isFocused != nil)
            }
            .onTapGesture {
                isFocused = nil
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        navigateViewModel.dismissOuter()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("새 레시피")
                        .font(CustomFontFactory.INTER_BOLD_16)
                }
            }
        }
    }
    
    @ViewBuilder
    private func PresentPreviewButton() -> some View {
        VStack {
            NavigationLink {
                RecipePreviewView(viewModel: viewModel)
            } label: {
                Text("미리보기")
                    .font(CustomFontFactory.INTER_BOLD_16)
                    .foregroundColor(.white)
                    .roundedRectangle(.GRAY_320_FILLED,
                                      focused: !viewModel.previewButtonIsDisabled)
            }
            .disabled(viewModel.previewButtonIsDisabled)
        }
    }
    
    @ViewBuilder
    private func DescriptionSection() -> some View {
        Section {
            VStack(spacing: 5) {
                TextEditor(text: $viewModel.recipeForm.description)
                    .font(CustomFontFactory.INTER_REGULAR_14)
                    .border(.gray)
                    .focused($isFocused, equals: .description)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button {
                                isFocused = nil
                            } label: {
                                Text("완료")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
            }
            .onTapGesture {
                if viewModel.recipeForm.description == "설명을 입력해주세요." {
                    viewModel.recipeForm.description = ""
                }
            }
            .onAppear {
                if viewModel.recipeForm.description.isEmpty{
                    viewModel.recipeForm.description = "설명을 입력해주세요."
                }
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
                PhotosPicker(selection: $viewModel.recipeForm.photosPickerItem) {
                    if viewModel.recipeMetadataHasThumbnail {
                        KFImage(URL(string: viewModel.recipeForm.thumbnail))
                            .resizable()
                            .frame(maxWidth: 320, maxHeight: 200)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .foregroundColor(.gray_bcbcbc)
                            .frame(maxWidth: 320, minHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.bottom, 20)
                .onChange(of: viewModel.recipeForm.photosPickerItem) { _ in
                    Task {
                        await viewModel.postMainImage()
                    }
                }
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
                              text: $viewModel.recipeForm.title)
                    .font(CustomFontFactory.INTER_BOLD_30)
                    .focused($isFocused, equals: .title)
                    
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
            LazyVGrid(columns: columns) {
                ForEach(viewModel.recipeForm.ingredients.indices, id: \.self) { i in
                    let id = viewModel.recipeForm.ingredients[i]
                    let ingredient: IngredientCell? = INGREDIENTS_DICTIONARY[id]
                    if let ingredient = ingredient {
                        VStack {
                            IngredientCellView(cell: ingredient)
                            Spacer()
                        }
                    }
                }
            }
        } header: {
            HStack {
                Text("필수재료")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
                
                Button {
                    viewModel.appendMainIngredientButtonTapped()
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
                .sheet(isPresented: $viewModel.mainIngredientViewIsPresnted) {
                    SelectIngredientView(viewModel: viewModel)
                        .onDisappear {
                            viewModel.searchText = ""
                        }
                }

            }
        }
    }
    
    @ViewBuilder
    private func OptionalIngredients() -> some View {
        Section {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.recipeForm.optionalIngredients, id: \.self) { id in
                    let ingredient: IngredientCell? = INGREDIENTS_DICTIONARY[id]
                    if let ingredient = ingredient {
                        IngredientCellView(cell: ingredient)
                    }
                }
            }
        } header: {
            HStack {
                Text("보조재료")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
                
                Button {
                    viewModel.appendOptionalIngredientButtonTapped()
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
                .sheet(isPresented: $viewModel.optioanlIngredientViewIsPresnted) {
                    SelectIngredientView(viewModel: viewModel)
                        .onDisappear {
                            viewModel.searchText = ""
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private func Steps() -> some View {
        Section {
            VStack(spacing: 10) {
                ForEach(viewModel.recipeForm.steps.indices, id: \.self) { i in
                    Button {
                        viewModel.presentStepFormView(i)
                    } label: {
                        HStack {
                            Text("\(i+1)단계")
                                .font(CustomFontFactory.INTER_BOLD_16)
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
                .onAppear {
                    print("trigger to nil")
                    viewModel.stepFormTrigger = nil
                }

            }
        }
        .sheet(item: $viewModel.stepFormTrigger) { item in
            StepFormView(viewModel: viewModel, stepIndex: item.index)
        }
    }
}

struct RecipeFormView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFormView(recipeId: nil)
    }
}
