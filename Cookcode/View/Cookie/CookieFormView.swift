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
    
    @EnvironmentObject var navigateVM: NavigateViewModel
    
    @State private var photosPickerItem: [PhotosPickerItem] = []
    @State private var isMerging: Bool = false
    @State private var avPlayer: AVPlayer?
    
    let service = ContentService()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if isMerging {
                    ProgressView()
                } else {
                    if let avPlayer {
                        VideoPlayer(player: avPlayer)
                            .frame(maxWidth: 300, maxHeight: 300)
                    } else {
                        Image(systemName: "video.square")
                            .resizable()
                            .frame(maxWidth: 300, maxHeight: 300)
                    }
                }
                
                PhotosPicker(selection: $photosPickerItem, maxSelectionCount: 8, matching: .videos) {
                    Text("비디오 선택")
                }
                .onChange(of: photosPickerItem) { newValue in
                    Task {
                        print("Merge start")
                        isMerging = true
                        var videoURL: [VideoURL] = []
                        
                        for item in photosPickerItem {
                            if let movie = try await item.loadTransferable(type: VideoURL.self) {
                                videoURL.append(movie)
                            } else {
                                print("Load fail")
                            }
                        }
                        
                        do {
                            try await mergeVideo(videoURL)
                        } catch {
                            print("merge fail")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task { await export() }
                    } label: {
                        Text("완료")
                            .foregroundColor(.mainColor)
                            .font(CustomFontFactory.INTER_SEMIBOLD_14)
                    }
                }
            }
        }
    }
    
    func mergeVideo(_ urls: [VideoURL]) async throws {
        let movie = AVMutableComposition()
        let videoTrack = movie.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrack = movie.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        for url in urls {
            let movie = AVURLAsset(url: url.url)
            guard let loadedVideoTrack = try await movie.loadTracks(withMediaType: .video).first else { return }
            
            let duration = try await movie.load(.duration)
            let range = CMTimeRangeMake(start: CMTime.zero, duration: duration)
            guard let mergedDuration = try await videoTrack?.asset?.load(.duration) else { break }
            
            try videoTrack?.insertTimeRange(range, of: loadedVideoTrack, at: mergedDuration)
            
            if let loadedAudioTack = try await movie.loadTracks(withMediaType: .audio).first {
                try audioTrack?.insertTimeRange(range, of: loadedAudioTack, at: mergedDuration)
            }
        }
        
        let item = AVPlayerItem(asset: movie)
        avPlayer = AVPlayer(playerItem: item)
        isMerging = false
    }
    
    func export(withPreset preset: String = AVAssetExportPresetHighestQuality,
                toFileType outputFileType: AVFileType = .mov) async {
        
        // Check the compatibility of the preset to export the video to the output file type.
        
        guard let video = avPlayer?.currentItem?.asset else { return }
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                               in: .userDomainMask).first else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())
        let url = documentDirectory.appendingPathComponent("mergeVideo-\(date).movie.mp4")
//
        guard await AVAssetExportSession.compatibility(ofExportPreset: preset,
                                                       with: video,
                                                       outputFileType: .mov) else {
            print("The preset can't export the video to the output file type.")
            return
        }

        // Create and configure the export session.
        guard let exportSession = AVAssetExportSession(asset: video,
                                                       presetName: preset) else {
            print("Failed to create export session.")
            return
        }
        exportSession.outputFileType = outputFileType
        exportSession.outputURL = url
        
        // Convert the video to the output file type and export it to the output URL.
        await exportSession.export()
        
        print("Success to export sesion")
        print("movieURL: \(url)")
        
        let result = await service.postVideos([VideoURL(url: url)])
        
        switch result {
        case .success(let success):
            print("업로드 성공: \(success.data.urls)")
        case .failure(let failure):
            print("업로드 실패")
        }
    }
}

struct CookieFormView_Previews: PreviewProvider {
    static var previews: some View {
        CookieFormView()
    }
}
