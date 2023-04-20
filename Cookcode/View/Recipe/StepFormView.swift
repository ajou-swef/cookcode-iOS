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
                VStack(spacing: 40) {
                    HStack {
                        Text("\(i+1)단계")
                            .font(CustomFontFactory.INTER_SEMIBOLD_20)
                        
                        Spacer()
                    }
                    .padding(.bottom, -20)
                    
                    PhotosPicker(selection: $viewModel.stepForms[i].photoPickerItems, maxSelectionCount: 3, matching: .images) {
                        
                        ForEach(0..<3, id: \.self) { j in
                            if j < viewModel.stepForms[i].imageDatas.count, let uiImage = UIImage(data: viewModel.stepForms[i].imageDatas[j]) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                
                            } else {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray_bcbcbc)
                            }
                        }
                        
                    }
                    .onChange(of: viewModel.stepForms[i].photoPickerItems) { _ in
                       Task {
                           viewModel.stepForms[i].imageDatas.removeAll()

                           for item in viewModel.stepForms[i].photoPickerItems {
                               if let data = try? await item.loadTransferable(type: Data.self) {
                                   viewModel.stepForms[i].imageDatas.append(data)
                               }
                           }
                       }
                   }
                    
                    TitleSection(i)
                    DescriptionSection(i)
                    
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
                .padding(.horizontal, 20)
                .tag(i)
            }
        }
        .ignoresSafeArea(.keyboard)
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
    
    @ViewBuilder
    private func DescriptionSection(_ index: Int) -> some View {
        Section {
            VStack {
                TextField("입력해주세요", text: $viewModel.stepForms[index].stepForm.description)
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
                TextField("입력해주세요", text: $viewModel.stepForms[index].stepForm.title)
                
                CCDivider()
            }
            .padding(.top, -30)
            
        } header: {
            HStack {
                Text("간략한 설명")
                    .font(CustomFontFactory.INTER_SEMIBOLD_14)
                
                Spacer()
            }
        }
    }
}

struct StepFormView_Previews: PreviewProvider {
    static var previews: some View {
        StepFormView(viewModel: RecipeFormViewModel(true), stepIndex: 0)
    }
}
