//
//  CookieFormViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/19.
//

import SwiftUI
import PhotosUI

final class CookieFormViewModel: ObservableObject {
    @Published private(set) var mainVideoURL: URL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
    
    @Published var photosItemPicker: PhotosPickerItem?
    @Published var pickedMovies: [VideoURL] = []
    @Published var avPlayer: AVPlayer?
    
    let cookie = AVMutableComposition()
    let videoCompositionTrack: AVMutableCompositionTrack?
    let audioCompositionTrack: AVMutableCompositionTrack?
    var cookieDuration: CMTime = .zero
    
    init() {
        videoCompositionTrack = cookie.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        audioCompositionTrack = cookie.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
    }
    
    @MainActor
    func appendVideoURL() async {
        if let data = try? await photosItemPicker?.loadTransferable(type: VideoURL.self) {
            
            pickedMovies.append(data)
            print("영상 추가 성공")
            
            do {
                try await appendCookie(data)
            } catch {
                print("쿠키 에러")
            }
            
            
        } else {
            print("영상 추가 실패")
        }
    }
    
    func appendCookie(_ videoURL: VideoURL) async throws {
        let movie = AVURLAsset(url: videoURL.url)
        
        guard let videoTrack = try await movie.loadTracks(withMediaType: .video).first else {
            return
        }
        
        guard let audioTrack = try await movie.loadTracks(withMediaType: .audio).first else {
            return
        }
        
        
        let movieDuration = try await movie.load(.duration)
        let movieRange = CMTimeRangeMake(start: cookieDuration, duration: movieDuration)
        
        try videoCompositionTrack?.insertTimeRange(movieRange, of: videoTrack, at: CMTime.zero)
        try audioCompositionTrack?.insertTimeRange(movieRange, of: audioTrack, at: CMTime.zero)
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())
        let url = documentDirectory.appendingPathComponent("mergeVideo-\(date).movie.mp4")
        await export(video: cookie, atURL: url)
    }
    
    @MainActor
    func export(video: AVAsset,
                withPreset preset: String = AVAssetExportPresetHighestQuality,
                toFileType outputFileType: AVFileType = .mov,
                atURL outputURL: URL) async {
        
        // Check the compatibility of the preset to export the video to the output file type.
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
        exportSession.outputURL = outputURL
        
        // Convert the video to the output file type and export it to the output URL.
        await exportSession.export()
        print("Success to export sesion")
        print("movieURL: \(outputURL.absoluteString)")
        
        avPlayer = AVPlayer(url: outputURL)
    }
}
