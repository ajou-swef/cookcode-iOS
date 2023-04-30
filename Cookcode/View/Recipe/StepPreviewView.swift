//
//  StepPreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import SwiftUI
import AVKit
import ObservedOptionalObject
import Kingfisher

struct StepPreviewView: View {
    
    let stepSequence: Int
    
    @ObservedOptionalObject var viewModel: RecipeFormViewModel?
    let step: RecipeStep?
    
    var title: String {
        guard let viewModel = viewModel else {
            return step?.title ?? "타이틀 에러"
        }
        return viewModel.stepFormTitle(at: stepSequence - 1)
    }
    
    var description: String {
        guard let viewModel = viewModel else {
            return step?.description ?? "설명 에러"
        }
        return viewModel.stepFormDescription(at: stepSequence - 1)
    }
    
    var stepViewIsPresented: Bool {
        guard let viewModel = viewModel else {
            return true
        }
        return viewModel.stepFormContainsAllRequiredInformation(at: stepSequence - 1)
    }
    
    var usesImage: Bool {
        guard let viewModel = viewModel else {
            return !(step?.photosIsEmpty ?? false)
        }
        return viewModel.stepFormContainsAnyImage(at: stepSequence - 1)
    }
    
    var contentURL: [String] {
        guard let viewModel = viewModel else {
            guard let step = step else {
                return []
            }
            return step.contentURLs
        }
        
        return ["https://picsum.photos/200", "https://picsum.photos/seed/picsum/200/300"]
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ContentViewer()
            
            HStack {
                Text("\(stepSequence)")
                    .font(CustomFontFactory.INTER_BOLD_30)
                    .foregroundColor(.mainColor)
                
                if stepViewIsPresented {
                    StepView()
                } else {
                    LackOfInformationView()
                }

            }
            .padding(.leading, 10)
            
            Spacer()
            
            ModifyStepButton()
            
        }
    }
    
    @ViewBuilder
    private func StepView() -> some View {
        VStack {
            VStack {
                Text("\(title)")
                    .font(CustomFontFactory.INTER_SEMIBOLD_20)
                
                Text("\(description)")
                    .font(CustomFontFactory.INTER_REGULAR_14)
            }
        }
    }
    
    @ViewBuilder
    private func ModifyStepButton() -> some View {
        if let viewModel = viewModel {
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
            .sheet(item: $viewModel.stepFormTrigger ?? .constant(nil)) { item in
                StepFormView(viewModel: viewModel, stepIndex: item.index)
            }
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
        if usesImage {
            TabView {
                ForEach(contentURL, id: \.self) { data in
                    KFImage(URL(string: data))
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .tabViewStyle(.page(indexDisplayMode: .always))
        } else {
            TabView {
                ForEach(contentURL, id: \.self) { data in
                    VideoPlayer(player: AVPlayer(url: URL(string: data)!)) {
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .tabViewStyle(.page(indexDisplayMode: .always))
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
}

//struct StepPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepPreviewView(stepSequence: 1,
//                        viewModel: RecipeFormViewModel())
//    }
//}
