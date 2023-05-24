//
//  PlayerView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVKit

struct PlayerViewController: UIViewControllerRepresentable {
    
    var avPlayer: AVPlayer

    private var player: AVPlayer {
        return avPlayer
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        controller.player?.play()
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}
