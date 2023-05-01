//
//  StepFormView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import AVKit
import SwiftUI
import PhotosUI
import Kingfisher

struct StepFormView: View {
    
    @ObservedObject var viewModel: RecipeFormViewModel
    
    init(viewModel: RecipeFormViewModel, stepIndex: Int) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView(selection: $viewModel.stepTabSelection) {
            ForEach(viewModel.recipeForm.steps.indices, id: \.self) {  i in
                VStack(spacing: 40) {
                    HStack {
                        Text("\(i+1)단계")
                            .font(CustomFontFactory.INTER_SEMIBOLD_20)
                        
                        Spacer()
                        
                        SelectContentTypeButton(i)
                    }
                    .padding(.bottom, -20)
                    
                    PhotosPicker(selection: $viewModel.stepItems, maxSelectionCount: viewModel.recipeForm.steps[i].maxSelection, matching: viewModel.recipeForm.steps[i].phpFilter) {
                        if viewModel.recipeForm.steps[i].useImageType {
                            SelectImageButton(i)
                        } else if viewModel.recipeForm.steps[i].useVideoType {
                            SelectVideoButton(i)
                        }
                    }
                    .onChange(of: viewModel.stepItems) { newValue in
                        if !newValue.isEmpty {
                            Task {
                                await viewModel.loadItemAt(i)
                            }
                        }
                   }
                    
                    TitleSection(i)
                    DescriptionSection(i)

                    
                    Spacer()
                    
                    BottomButton(i)
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .tag(viewModel.recipeForm.steps[i].id)
                .onDisappear {
                    viewModel.onDisappearStep()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    @ViewBuilder
    private func SelectImageButton(_ i: Int) -> some View {
        ForEach(0..<3, id: \.self) { j in
            if j < viewModel.recipeForm.steps[i].imageURLs.count {
                KFImage(URL(string: viewModel.recipeForm.steps[i].imageURLs[j]))
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .cornerRadius(15)
                
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .foregroundColor(.gray_bcbcbc)
            }
        }
    }
    
    @ViewBuilder
    private func SelectVideoButton(_ i: Int) -> some View {
        ForEach(0..<2, id: \.self) { j in
            if j < viewModel.recipeForm.steps[i].videoURLs.count {
                if let url = URL(string: viewModel.recipeForm.steps[i].videoURLs[j]) {
                    
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(maxWidth: .infinity, maxHeight: 100)
                }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .foregroundColor(.gray_bcbcbc)
                    .overlay {
                        Image(systemName: "video.fill")
                            .resizable()
                            .frame(width: 60, height: 40)
                            .foregroundColor(.white)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func SelectContentTypeButton(_ i: Int) -> some View {
        HStack {
            Button {
                viewModel.changeToImageButtonTapped(i)
            } label: {
                Text("이미지")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
            }
            .padding(.leading, 10)
            .foregroundColor(viewModel.recipeForm.steps[i].useImageType ?
                .white : .primary)
            
            Spacer()
            
            Button {
                viewModel.changeContentTypeToVideo(i)
            } label: {
                Text("동영상")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
            }
            .padding(.trailing, 10)
            .foregroundColor(viewModel.recipeForm.steps[i].useVideoType ?
                .white : .primary)

        }
        .alert("현재 선택된 컨텐츠가 삭제됩니다.", isPresented: $viewModel.isPresentedContentDeleteAlert) {
            Button("삭제") {
                viewModel.deleteContentsButtonInAlertTapped(i)
            }
            Button("취소", role: .cancel) {   }
        }
        .frame(width: 140, height: 25)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(
            
            HStack {
                Spacer()
                    .hidden(viewModel.recipeForm.steps[i].useImageType)
                
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.mainColor)
                    .frame(width: 80)
                    .padding(5)
                
                Spacer()
                    .hidden(viewModel.recipeForm.steps[i].useVideoType)
            }
        )
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray_bcbcbc)
        )
        .padding(.trailing, 10)
        .animation(.spring(), value: viewModel.recipeForm.steps[i].contentType)
    }
    
    @ViewBuilder
    private func BottomButton(_ i: Int) -> some View {
        HStack {
            Button {
                viewModel.removeThisStep(i)
            } label: {
                Image(systemName: "trash.square")
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .foregroundColor(.gray808080)
            }
            .hidden(!viewModel.trashButtonIsShowing)

            
            Button {
                viewModel.appendNewStepForm()
            } label: {
                Text("스텝 추가")
                    .foregroundColor(.white)
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                    .roundedRectangle(.ORANGE_280_FILLED)
            }
        }
    }
    
    @ViewBuilder
    private func DescriptionSection(_ index: Int) -> some View {
        Section {
            VStack {
                TextField("입력해주세요", text: $viewModel.recipeForm.steps[index].description)
                    .font(CustomFontFactory.INTER_REGULAR_14)
            }
            .padding(.top, -30)
        } header: {
            HStack {
                Text("자세한 설명")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func TitleSection(_ index: Int) -> some View {
        Section {
            VStack {
                TextField("입력해주세요", text: $viewModel.recipeForm.steps[index].title)
                
                CCDivider()
            }
            .padding(.top, -30)
            
        } header: {
            HStack {
                Text("스텝 제목")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
            }
        }
    }
}

//struct StepFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepFormView(viewModel: RecipeFormViewModel(true), stepIndex: 0)
//    }
//}
