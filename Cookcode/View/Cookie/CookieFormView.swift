//
//  CookieFormView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/19.
//

import SwiftUI
import PhotosUI
import AVKit

struct CookieFormView: View {
    
    @StateObject private var viewModel: CookieFormViewModel = .init()
    
    var body: some View {
        VStack {
            if let player = viewModel.avPlayer {
                VideoPlayer(player: player)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .frame(maxHeight: 400)
                    .padding(.horizontal, 20)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    pickedMovies()
                    moviePicker()
                }
            }
        }
    }
    
    @ViewBuilder
    private func pickedMovies() -> some View {
        ForEach(viewModel.pickedMovies) { movie in
            VideoPlayer(player: AVPlayer(url: movie.url))
                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                .frame(maxHeight: 100)
        }
    }
    
    @ViewBuilder
    private func moviePicker() -> some View {
        PhotosPicker(selection: $viewModel.photosItemPicker) {
            moviePickerLabel()
        }
        .onChange(of: viewModel.photosItemPicker) { newValue in
            Task { await viewModel.appendVideoURL() }
        }
    }
    
    @ViewBuilder
    private func moviePickerLabel() -> some View {
        VStack {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(CGSize(width: 2, height: 1), contentMode: .fit)
                .frame(maxHeight: 100)
            
            Text("영상 추가하기")
                .font(CustomFontFactory.INTER_BOLD_16)
        }
        .padding(20)
        .foregroundColor(.mainColor)
        .overlay(
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .stroke(Color.mainColor, lineWidth: 5)
        )
    }
}

struct CookieFormView_Previews: PreviewProvider {
    static var previews: some View {
        CookieFormView()
    }
}
