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
            
            Group {
                HStack {
                    Text("\(stepSequence)")
                        .font(CustomFontFactory.INTER_TITLE)
                        .foregroundColor(.mainColor)
                    
                    VStack {
                        if !viewModel.stepForms[stepSequence - 1].fillAllRequiredInformation {
                            Text("정보가 부족합니다.")
                                .foregroundColor(.red)
                                .font(CustomFontFactory.INTER_SEMIBOLD_20)
                            
                            Text("해당 스텝을 수정해주세요.")
                                .foregroundColor(.red)
                                .font(CustomFontFactory.INTER_REGULAR_14)
                        }
                        
                        Text("\(viewModel.stepForms[stepSequence - 1].stepForm.title)")
                    }

                }
            }
            .padding(.leading, 10)
            
            Button {
                viewModel.showStepFormView(stepSequence - 1)
            } label: {
                Text("임시수정 버튼")
            }
            
            Spacer()
        }
        .sheet(item: $viewModel.stepFormTrigger) { item in
            StepFormView(viewModel: viewModel, stepIndex: item.index)
        }
    }
    
    @ViewBuilder
    private func ContentViewer() -> some View {
        if viewModel.stepForms[stepSequence - 1].containsAnyContent {
            if viewModel.stepForms[stepSequence - 1].containsAnyImage {
                ImageContent()
            }
            
            if viewModel.stepForms[stepSequence - 1].containsAnyVideoURL {
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
                    .stroke(lineWidth: 30)
                    .foregroundColor(.gray_bcbcbc)
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

//struct StepPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepPreviewView()
//    }
//}
