//
//  CookieFormViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import PhotosUI

final class CookieFormViewModel: ObservableObject {
    
    @Published private(set) var selectedVideoThumbnails: [VideoThumbnail] = []
    @Published private var _photosPickerItem: PhotosPickerItem?
    @Published var isMerging: Bool = false
    @Published private(set) var mergedAVPlayer: AVPlayer?
    @Published private var _videoIsPresented: Bool = false
    
    private let contentService: ContentServiceProtocol
    
    init(contentService: ContentServiceProtocol) {
        self.contentService = contentService
    }
    
    var videoIsPresented: Bool {
        get { _videoIsPresented }
        set { _videoIsPresented = newValue }
    }
    
    var photosPickerItem: PhotosPickerItem? {
        get { _photosPickerItem }
        set {_photosPickerItem = newValue }
    }
    
    var mergedVideoThumbnail: UIImage? {
        guard let thumbanil = selectedVideoThumbnails.first else { return nil }
        
        switch thumbanil.loadState {
        case .loaded(let image):
            return image
        case .loading:
            return nil
        }
    }
    
    @MainActor
    func loadURL() async {
        
        guard let photosPickerItem else { return }
        isMerging = true
        
        do {
            guard let videoURL = try await photosPickerItem.loadTransferable(type: VideoURL.self) else { return }
            try await appendThumbnail(videoURL)
            try await mergeVideo()
        } catch {
            print("\(error.localizedDescription)")
        }
        
        isMerging = false
    }
    
    @MainActor
    func thumbnailTapped(at: Int) async {
        selectedVideoThumbnails.remove(at: at)
        
        do {
            try await mergeVideo()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func appendThumbnail(_ url: VideoURL) async throws {
        
        let asset = AVURLAsset(url: url.url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        if let cgImage = try? imageGenerator.copyCGImage(at: .zero, actualTime: nil) {
            selectedVideoThumbnails.append(VideoThumbnail(url: url.url, loadState: .loaded(UIImage(cgImage: cgImage))))
        }
    }
    
    @MainActor
    private func mergeVideo() async throws {
        
        let movie = AVMutableComposition()
        let videoTrack = movie.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrack = movie.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        for url in selectedVideoThumbnails {
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
        mergedAVPlayer = AVPlayer(playerItem: item)
        print("merge end")
        
        isMerging = false
    }
}
