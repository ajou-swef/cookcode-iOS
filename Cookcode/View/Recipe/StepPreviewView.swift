//
//  StepPreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import SwiftUI
import AVKit

struct StepPreviewView: View {
    
    let stepSequence: Int
    @ObservedObject var viewModel: RecipeFormViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ContentViewer()
            
            HStack {
                Text("\(stepSequence)")
                    .font(CustomFontFactory.INTER_BOLD_30)
                    .foregroundColor(.mainColor)
                
                if viewModel.stepFormContainsAllRequiredInformation(at: stepSequence - 1) {
                    StepView()
                } else {
                    LackOfInformationView()
                }

            }
            .padding(.leading, 10)
            
            Spacer()
            
            ModifyStepButton()
            
        }
        .sheet(item: $viewModel.stepFormTrigger) { item in
            StepFormView(viewModel: viewModel, stepIndex: item.index)
        }
    }
    
    @ViewBuilder
    private func StepView() -> some View {
        VStack {
            VStack {
                Text("\(viewModel.stepFormTitle(at: stepSequence - 1))")
                    .font(CustomFontFactory.INTER_SEMIBOLD_20)
                
                Text("\(viewModel.stepFormDescription(at: stepSequence - 1))")
                    .font(CustomFontFactory.INTER_REGULAR_14)
            }
        }
    }
    
    @ViewBuilder
    private func ModifyStepButton() -> some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.showStepFormView(stepSequence - 1)
            } label: {
                Text("수정하기")
                    .roundedRectangle(.ORANGE_280_FILLED)
                    .foregroundColor(.white)
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                    .padding(.bottom, 10)
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func LackOfInformationView() -> some View {
        VStack {
            Text("정보가 부족합니다.")
                .foregroundColor(.red)
                .font(CustomFontFactory.INTER_SEMIBOLD_20)
            
            Text("해당 스텝을 수정해주세요.")
                .foregroundColor(.red)
                .font(CustomFontFactory.INTER_REGULAR_14)
        }
    }
    
    @ViewBuilder
    private func ContentViewer() -> some View {
        if viewModel.stepFormContainsAnyContent(at: stepSequence - 1) {
            if viewModel.stepFormContainsAnyImage(at: stepSequence - 1) {
                ImageContent()
            }
            
            if viewModel.stepFormContainsAnyVideoURL(at: stepSequence - 1) {
                VideoContent()
            }
            
        } else {
            EmptyContent()
        }
    }
    
    @ViewBuilder
    private func EmptyContent() -> some View {
        Image(systemName: "photo.fill")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: 300)
            .foregroundColor(.gray_bcbcbc)
            .background {
                Rectangle()
                    .foregroundColor(.gray_bcbcbc)
                    .overlay {
                        Rectangle()
                            .padding(.vertical, 20)
                            .foregroundColor(.white)
                    }
            }
    }
    
    @ViewBuilder
    private func VideoContent() -> some View {
        TabView {
            ForEach(viewModel.stepForms[stepSequence - 1].videoURLs, id: \.self) {
                VideoPlayer(player: AVPlayer(url: $0.url)) {
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
    
    @ViewBuilder
    private func ImageContent() -> some View {
        TabView {
            ForEach(viewModel.stepForms[stepSequence - 1].imageDatas, id: \.self) { data in
                if let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct StepPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        StepPreviewView(stepSequence: 1,
                        viewModel: RecipeFormViewModel())
    }
}
