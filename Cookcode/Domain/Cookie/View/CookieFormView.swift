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
                VStack(spacing: 20) {
                    Text("미리보기")
                        .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                    
                    cookieThumbnail()
                        .padding(.bottom, 10)
                    
                    mergedVideos()
                        .padding(.bottom, 30)
                    
                    titleSection()
                        .padding(.bottom, 10)
                    
                    descriptionSection()
                }
                .padding()
            }
            .navigationTitle("쿠키 생성")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                dismissButton()
                completeButton()
            }
            .alert(viewModel.serviceAlert.title, isPresented: $viewModel.serviceAlert.isPresented) {
                ViewAlert.cancelButton
            }
            .disableWhenUploading(viewModel.isUploading)
        }
    }
    
    @ViewBuilder
    private func mergedVideos() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(viewModel.selectedVideoThumbnails) { thumbnail in
                    mergedVideoThumbnail(thumbnail)
                }
                
                Color.clear
                    .frame(width: 100)
                    .overlay {
                        ProgressView()
                    }
                    .presentIf(viewModel.isMerging)
                
                selectVideoButton()
            }
            .padding(.top)
        }
    }
    
    @ViewBuilder
    private func mergedVideoThumbnail(_ thumbnail: VideoThumbnail) -> some View {
        VideoLoadView(state: thumbnail.loadState)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
            .frame(width: 100, alignment: .top)
            .overlay(alignment: .topTrailing) {
                Button {
                    Task { await viewModel.videoThumbnailXmarkTapped(thumbnail) }
                } label: {
                    Image(systemName: "xmark.app.fill")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .offset(x: 10, y: -10)
                }
            }
    }
    
    @ViewBuilder
    private func cookieThumbnail() -> some View {
        Group {
            if viewModel.isMerging {
                Color.clear
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                    .frame(maxWidth: 200)
                    .overlay(alignment: .center) {
                        ProgressView()
                    }
                    .presentIf(viewModel.isMerging)
            } else {
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
                } else {
                    Color.clear
                        .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                        .frame(maxWidth: 200)
                        .overlay {
                            Text("영상을 선택하시면\n 제작될 영상을 미리 볼 수 있습니다.")
                                .padding(-50)
                                .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
                                .foregroundColor(.gray808080)
                                .multilineTextAlignment(.center)
                        }
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
    }
    
    @ViewBuilder
    private func descriptionSection() -> some View {
        VStack(alignment: .leading) {
            Text("쿠키 설명")
                .font(CustomFontFactory.INTER_BOLD_16)
            
            TextField("입력해주세요", text: $viewModel.cookieForm.description)
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
        }
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
                Text("업로드")
                    .font(.custom(CustomFont.interSemiBold.rawValue, size: 16))
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
                .frame(width: 100)
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
