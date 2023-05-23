//
//  CookieListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVFoundation

final class CookieListViewModel: ObservableObject {
    @Published var avPlayers: [AVPlayer] = [
        AVPlayer(playerItem: AVPlayerItem(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)),
        AVPlayer(playerItem: AVPlayerItem(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)),
        AVPlayer(playerItem: AVPlayerItem(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!)),
    ]
}
