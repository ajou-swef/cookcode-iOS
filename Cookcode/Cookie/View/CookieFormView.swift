//
//  CookieFormView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/22.
//

import SwiftUI
import PhotosUI
import AVKit

struct CookieFormView: View {
    
    @StateObject private var viewModel = CookieFormViewModel(cookieService: CookieService())
    @EnvironmentObject var navigateVM: NavigateViewModel
    @EnvironmentObject var progressVM: CookieProgress
    @Environment(\.dismiss) var dismiss

    let service = ContentService()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    cookieThumbnail()
                        .opacity(viewModel.isMerging ? 0.3 : 1)
                        .disabled(viewModel.isMerging)
                        .overlay {
                            ProgressView()
                                .tint(.mainColor)
                                .hidden(!viewModel.isMerging)
                        }

                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.selectedVideoThumbnails.indices, id: \.self) { index in
                                
                                let thumbnail = viewModel.selectedVideoThumbnails[index]
                                
                                Button {
                                    Task { await viewModel.thumbnailTapped(at: index) }
                                } label: {
                                    VideoLoadView(state: thumbnail.loadState)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                                        .frame(width: 100, alignment: .top)
                                }
                            }
                            
                            
                            ProgressView()
                                .hidden(!viewModel.isMerging)
                                .frame(width: 100, height: 100)
                                .tint(.mainColor)
                            
                            selectVideoButton()
                            
                        }
                        .offset(x: 20)
                        .padding(.trailing, 40)
                    }
                    
                    titleSection()
                    descriptionSection()
                }
            }
            .navigationTitle("쿠키 생성")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                dismissButton()
                completeButton()
            }
            .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
                ServiceAlert.CANCEL_BUTTON
            }
            .disableWhenUploading(viewModel.isUploading)
        }
    }
    
    @ViewBuilder
    private func cookieThumbnail() -> some View {
        if let thumbnail = viewModel.mergedVideoThumbnail {
            Button {
                viewModel.videoIsPresented = true
            } label: {
                Image(uiImage: thumbnail)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                    .frame(maxWidth: 200)
            }
            .sheet(isPresented: $viewModel.videoIsPresented) {
                VideoPlayer(player: viewModel.mergedAVPlayer)
                    .ignoresSafeArea()
                    .scaledToFill()
                    .onAppear {
                        viewModel.mergedAVPlayer?.play()
                    }
            }
        }
    }
    
    
    @ViewBuilder
    private func titleSection() -> some View {
        VStack(alignment: .leading) {
            Text("쿠키 이름")
                .font(CustomFontFactory.INTER_BOLD_16)
            
            TextField("쿠키 제목을 입력해주세요", text: $viewModel.cookieForm.title)
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
        }
        .padding(.leading)
    }
    
    @ViewBuilder
    private func descriptionSection() -> some View {
        VStack(alignment: .leading) {
            Text("쿠키 설명")
                .font(CustomFontFactory.INTER_BOLD_16)
            
            TextField("입력해주세요", text: $viewModel.cookieForm.description)
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
        }
        .padding(.leading)
    }
    
    
    
    fileprivate func completeButton() -> ToolbarItem<(), Button<Text>> {
        return ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                Task {
                    await viewModel.export()
                    progressVM.postCookie(cookieForm: viewModel.cookieForm)
                    navigateVM.dismissOuter()
                }
            } label: {
                Text("완료")
                    .font(CustomFontFactory.INTER_SEMIBOLD_20)
                    .foregroundColor(.black)
            }
        }
    }
    
    
    fileprivate func dismissButton() -> ToolbarItem<(), Button<some View>> {
        return ToolbarItem(placement: .navigationBarLeading) {
            Button {
                navigateVM.dismissOuter()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            }
            
        }
    }
    
    @ViewBuilder
    private func selectVideoButton() -> some View {
        PhotosPicker(selection: $viewModel.photosPickerItem, matching: .videos) {
            Image(systemName: "plus.square")
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .frame(width: viewModel.mergedVideoThumbnail == nil ? 250 : 100)
                .foregroundColor(.primary)
        }
        .onChange(of: viewModel.photosPickerItem) { newValue in
            Task { await viewModel.loadURL() } 
        }
    }
}

struct CookieFormView_Previews: PreviewProvider {
    static var previews: some View {
        CookieFormView()
    }
}
