//
//  SlidInfoView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/19.
//

import SwiftUI
import PhotosUI

struct SlidInfoView: View {
    
    @EnvironmentObject var navigateViewModel: NavigateViewModel
    @StateObject private var createRecipeViewModel: CreateRecipeViewModel = .init()
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedData: Data?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TitleSection()
                    
                    if let selectedData, let uiImage = UIImage(data: selectedData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(maxWidth: 300, maxHeight: 300)
                            .scaledToFit()
                        
                    } else {
                        PhotosPicker(selection: $selectedItem) {
                            Text("사진 고르기")
                        }
                    }
                    
                    CCDivider()
                    
                    MainIngredients()
                    CCDivider()
                    OptionalIngredients()
                }
                .padding(.horizontal, 10)
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Retrive selected asset in the form of Data
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedData = data
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func TitleSection() -> some View {
        Section {
            HStack {
                TextField("입력해주세요",
                          text: $createRecipeViewModel.recipeMetadata.title)
                    .font(CustomFontFactory.INTER_TITLE)
                
                Spacer()
            }
        } header: {
            HStack {
                Text("레시피 이름")
                    .font(CustomFontFactory.INTER_SEMIBOLD_12)
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
                    .font(CustomFontFactory.INTER_SEMIBOLD_12)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("추가")
                            .font(CustomFontFactory.INTER_REGULAR_12)
                    }
                    .foregroundColor(.primary)
                }

            }
        }
    }
    
    @ViewBuilder
    private func OptionalIngredients() -> some View {
        Section {
            
        } header: {
            HStack {
                Text("보조재료")
                    .font(CustomFontFactory.INTER_SEMIBOLD_12)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("추가")
                            .font(CustomFontFactory.INTER_REGULAR_12)
                    }
                    .foregroundColor(.primary)
                }

            }
        }
    }
}

struct SlidInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SlidInfoView()
    }
}
