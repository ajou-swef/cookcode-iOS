//
//  CookieFormViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import PhotosUI

final class CookieFormViewModel: ObservableObject {
    
    enum ViewState {
        case none
        case videoMerging
        case cookieUploading
        
        var isMerging: Bool {
            switch self {
            case .videoMerging:
                return true
            default:
                return false
            }
        }
        
        var isUploading: Bool {
            switch self {
            case .cookieUploading:
                return true
            default:
                return false
            }
        }
    }
    
    @Published private(set) var selectedVideoThumbnails: [VideoThumbnail] = []
    @Published var photosPickerItem: [PhotosPickerItem] = []
    @Published private(set) var mergedAVPlayer: AVPlayer?
    @Published private var _videoIsPresented: Bool = false
    @Published private(set) var viewState: ViewState = .none
    
    @Published private var _cookieForm: CookieForm = .init()
    @Published var serviceAlert: ViewAlert = .init()
    
    
    var isMerging: Bool {
        viewState.isMerging
    }
    
    var isUploading: Bool {
        viewState.isUploading
    }
    
    var cookieForm: CookieForm {
        get { _cookieForm }
        set { _cookieForm = newValue }
    }
    
    private let cookieService: CookieServiceProtocol
    
    init(cookieService: CookieServiceProtocol) {
        self.cookieService = CookieServiceInjector.select(service: cookieService)
    }
    
    var videoIsPresented: Bool {
        get { _videoIsPresented }
        set { _videoIsPresented = newValue }
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
        viewState = .videoMerging
        
        do {
            for item in photosPickerItem {
                guard let videoURL = try await item.loadTransferable(type: VideoURL.self) else { return }
                try await appendThumbnail(videoURL)
                try await mergeVideo()
            }
            
        } catch {
            print("\(error.localizedDescription)")
        }
        
        photosPickerItem = []
        viewState = .none
    }

    @MainActor
    private func appendThumbnail(_ url: VideoURL) async throws {
        
        let asset = AVURLAsset(url: url.url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        if let cgImage = try? imageGenerator.copyCGImage(at: .zero, actualTime: nil) {
            let uiImage = UIImage(cgImage: cgImage)
            selectedVideoThumbnails.append(VideoThumbnail(url: url.url, loadState: .loaded(uiImage)))
            if selectedVideoThumbnails.count == 1 {
                cookieForm.thumbnailData = uiImage.pngData()
            }
        }
    }
    
    @MainActor
    func videoThumbnailXmarkTapped(_ thumbnail: VideoThumbnail) async {
        guard let index = selectedVideoThumbnails.firstIndex(where: { $0 == thumbnail }) else { return }
        selectedVideoThumbnails.remove(at: index)
        
        do {
            try await mergeVideo()
        } catch {
            print("\(error.localizedDescription)")
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
    }
    
    @MainActor
    func export(ithPreset preset: String = AVAssetExportPresetHighestQuality,
                toFileType outputFileType: AVFileType = .mov) async {
        
        viewState = .cookieUploading
        
        guard let video = mergedAVPlayer?.currentItem?.asset else { return }
        guard let documentDirectory = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first else { return }

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
        cookieForm.videoURL = url 
        print("Success to export sesion")
        print("movieURL: \(url)")
    }
}
