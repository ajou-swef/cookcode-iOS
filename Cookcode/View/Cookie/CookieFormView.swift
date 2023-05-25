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
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    
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
                        HStack(spacing: 10) {
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
                
        } else {
            Image(systemName: "questionmark.video")
                .resizable()
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .frame(maxWidth: 200)
        }
    }
    
    
    @ViewBuilder
    private func titleSection() -> some View {
        VStack(alignment: .leading) {
            Text("쿠키 이름")
                .font(CustomFontFactory.INTER_BOLD_16)
            
            TextField("쿠키 제목을 입력해주세요", text: $title)
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
        }
        .padding(.leading)
    }
    
    @ViewBuilder
    private func descriptionSection() -> some View {
        VStack(alignment: .leading) {
            Text("쿠키 설명")
                .font(CustomFontFactory.INTER_BOLD_16)
            
            TextField("입력해주세요", text: $description)
                .font(CustomFontFactory.INTER_SEMIBOLD_14)
        }
        .padding(.leading)
    }
    
    
    
    fileprivate func completeButton() -> ToolbarItem<(), Button<Text>> {
        return ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                Task { await viewModel.export() }
            } label: {
                Text("완료")
                    .foregroundColor(.mainColor)
                    .font(CustomFontFactory.INTER_SEMIBOLD_20)
            }
        }
    }
    
    
    fileprivate func dismissButton() -> ToolbarItem<(), Button<some View>> {
        return ToolbarItem(placement: .navigationBarLeading) {
            Button {
                navigateVM.dismissOuter()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.mainColor)
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
                .foregroundColor(.mainColor)
        }
        .onChange(of: viewModel.photosPickerItem) { newValue in
            Task { await viewModel.loadURL() } 
        }
    }
   
    
//    func export(withPreset preset: String = AVAssetExportPresetHighestQuality,
//                toFileType outputFileType: AVFileType = .mov) async {
//
//        // Check the compatibility of the preset to export the video to the output file type.
//
//        guard let video = avPlayer?.currentItem?.asset else { return }
//
//        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
//                                                               in: .userDomainMask).first else { return }
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .short
//        let date = dateFormatter.string(from: Date())
//        let url = documentDirectory.appendingPathComponent("mergeVideo-\(date).movie.mp4")
////
//        guard await AVAssetExportSession.compatibility(ofExportPreset: preset,
//                                                       with: video,
//                                                       outputFileType: .mov) else {
//            print("The preset can't export the video to the output file type.")
//            return
//        }
//
//        // Create and configure the export session.
//        guard let exportSession = AVAssetExportSession(asset: video,
//                                                       presetName: preset) else {
//            print("Failed to create export session.")
//            return
//        }
//
//        exportSession.outputFileType = outputFileType
//        exportSession.outputURL = url
//
//        // Convert the video to the output file type and export it to the output URL.
//        await exportSession.export()
//
//        print("Success to export sesion")
//        print("movieURL: \(url)")
//
////        let result = await service.postVideos([VideoURL(url: url)])
//
////        switch result {
////        case .success(let success):
////            print("업로드 성공: \(success.data.urls)")
////        case .failure(let failure):
////            print("업로드 실패")
////        }
//    }
}

struct CookieFormView_Previews: PreviewProvider {
    static var previews: some View {
        CookieFormView()
    }
}
