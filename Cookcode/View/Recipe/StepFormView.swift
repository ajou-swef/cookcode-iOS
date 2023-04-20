//
//  StepFormView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import AVKit
import SwiftUI
import PhotosUI

struct StepFormView: View {
    
    @ObservedObject var viewModel: RecipeFormViewModel
    @State private var photoItem: PhotosPickerItem?
    @State private var videoURL: VideoURL? 
//    @State private var tabSelection: Int
    
    init(viewModel: RecipeFormViewModel, stepIndex: Int) {
        self.viewModel = viewModel
//        self.tabSelection = stepIndex
    }
    
    var body: some View {
        TabView(selection: $viewModel.stepSelction) {
            ForEach(viewModel.stepForms.indices, id: \.self) {  i in
                VStack {
                    
                    HStack {
                        Text("\(i+1)단계")
                            .font(CustomFontFactory.INTER_SEMIBOLD_20)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            viewModel.trashButtonTapped(i)
                        } label: {
                            Image(systemName: "trash.square")
                                .resizable()
                                .frame(maxWidth: 50, maxHeight: 50)
                                .foregroundColor(.gray808080)
                        }
                        .hidden(!viewModel.isRemovableStep)

                        
                        Button {
                            viewModel.addStepButotnTapped()
                        } label: {
                            Text("스텝 추가")
                                .foregroundColor(.white)
                                .font(CustomFontFactory.INTER_SEMIBOLD_14)
                                .roundedRectangle(.ORANGE_280_FILLED)
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 10)
                .tag(i)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
//        .onChange(of: photoItem) { newItem in
//            print("onChange")
//            Task {
//                // Retrive selected asset in the form of Data
//                do {
//                    if let video = try? await newItem?.loadTransferable(type: VideoURL.self) {
//                        videoURL = video
//                    }
//                } catch {
//                    print("\(error)")
//                }
//            }
//        }
    }
}

struct StepFormView_Previews: PreviewProvider {
    static var previews: some View {
        StepFormView(viewModel: RecipeFormViewModel(true), stepIndex: 0)
    }
}
