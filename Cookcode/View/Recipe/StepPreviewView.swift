//
//  StepPreviewView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/26.
//

import SwiftUI
import AVKit

struct StepPreviewView: View {
    
    let contentWrappedStepForm: ContentWrappedStepForm
    let step: Int
    @ObservedObject var viewModel: RecipeFormViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if contentWrappedStepForm.useImage {
                TabView {
                    ForEach(contentWrappedStepForm.imageDatas, id: \.self) { data in
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
            
            if contentWrappedStepForm.useVideo {
                TabView {
                    ForEach(contentWrappedStepForm.videoURLs, id: \.self) {
                        VideoPlayer(player: AVPlayer(url: $0.url)) {
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
            
            Group {
                HStack {
                    Text("\(step)")
                        .font(CustomFontFactory.INTER_TITLE)
                        .foregroundColor(.mainColor)
                    
                    Text("\(contentWrappedStepForm.stepForm.title)")

                }
            }
            .padding(.leading, 10)
            
            Button {
                viewModel.showStepFormView(step - 1)
            } label: {
                Text("수정")
            }
            
            Spacer()
        }
        .sheet(item: $viewModel.stepFormTrigger) { item in
            StepFormView(viewModel: viewModel, stepIndex: item.index)
        }
    }
}

//struct StepPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepPreviewView()
//    }
//}
